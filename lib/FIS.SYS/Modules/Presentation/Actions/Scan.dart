import 'dart:convert';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Presentation/Providers/PresentationProvider.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:provider/provider.dart';
import 'package:screen/screen.dart';

import '../../../../F.Utils/SentryUtils.dart';
import '../../../../F.Utils/SrceenExtensions.dart';
import '../../../../F.Utils/Utils.dart';
import '../../../Components/ComponentsBase.dart';
import '../../../Skins/Icon.dart';
import '../../../Skins/KhaoThi/SkinColor.dart';
import '../../../Skins/Typography.dart';
import '../../../Styles/Colors.dart';
import '../../../Styles/Icons.dart';
import '../../../Styles/Spacer.dart';
import '../../Students/StudentItem.dart';
import '../Answer.dart';
import '../DA/PresentDA.dart';
import '../PresentRequest.dart';
import '../Providers/PresentProvider.dart';
import '../Providers/ScanProvider.dart';
import '../Question.dart';
import 'AnswerSummary.dart';
import 'DrawMarker.dart';
import 'ListStudentAnswer.dart';

class ScanAnserApp extends StatefulWidget {
  final List<StudentItem> students;
  final Question question;
  final int presentId;
  final MqttServerClient client;
  const ScanAnserApp(this.students, this.question, this.presentId,
      {this.client});
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<ScanAnserApp> with WidgetsBindingObserver {
  CameraController controller;
  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  bool isFlip = false;
  List<CameraDescription> cameras;
  int wImage = 0;
  int hImage = 0;
  List<Answer> answers = <Answer>[];
  Map<int, String> studentCard = {};
  // List<StudentItem> students;
  // Question question;
  PresentDA presentDA = PresentDA();
  ScanProvider scanProvider;
  bool isSending = false;
  static const opencv = MethodChannel('api.opencv.dev/opencv');

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (controller == null || !controller.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (controller != null) {
        onNewCameraSelected();
      }
    }
  }

  Future<void> onNewCameraSelected() async {
    if (controller != null) {
      await controller.dispose();
    }

    controller =
        CameraController(cameras[0], ResolutionPreset.high, enableAudio: false);

    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
      if (controller.value.hasError) {
        Utils.console('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();

      final width = controller.value.previewSize.width.toInt();
      final height = controller.value.previewSize.height.toInt();
      await controller.detectorAruco((data) {
        processCameraResponse(data, width, height);
      });
    } on CameraException catch (e) {
      Utils.console(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getFlip() async {
    final flip = await _storage.read(key: 'activeFlip');
    if (flip == '1') {
      setState(() {
        isFlip = true;
      });
    } else {
      setState(() {
        isFlip = false;
      });
    }
  }

  @override
  void initState() {
    Screen.keepOn(true);
    super.initState();
    getFlip();
    WidgetsBinding.instance.addObserver(this);

    for (final student in widget.students) {
      studentCard[student.cardNumber] = student.lastName;
    }
    availableCameras().then((value) {
      cameras = value;
      onNewCameraSelected();
    });
  }

  bool _isDetecting = false;
  int i = 0;
  // ignore: unused_element
  Future _processCameraImage(CameraImage image) async {
    if (_isDetecting) {
      return;
    }
    i++;
    _isDetecting = true;
    final img = _concatenatePlanes(image.planes);
    if (image == null) {
      return;
    }
    await opencv.invokeMethod('detectMarker', <String, dynamic>{
      'byteImg': img,
      'width': image.width,
      'height': image.height,
      'flip': isFlip,
    }).then((data) {
      processCameraResponse(data, image.width, image.height);
    }).catchError((error) async {
      final event = await getSentryEnvEvent(error, null);

      // ignore: unawaited_futures
      SentryUtils.sentry.capture(event: event);
      _isDetecting = false;
    });
  }

  void processCameraResponse(dynamic data, int width, int height) {
    i++;
    final answerResponses =
        data.map((c) => Answer.fromJson(json.decode(c))).toList();

    for (final answerResponse in answerResponses) {
      answerResponse.isCorrect =
          answerResponse.answer == scanProvider.question.dataResponse;
      final student = scanProvider.students.firstWhere(
          (element) => element.cardNumber == answerResponse.id,
          orElse: () => null);

      if (student != null) {
        student.answer = answerResponse.answer;
      }

      final answer = answers.firstWhere(
          (element) => element.id == answerResponse.id,
          orElse: () => null);

      if (answer == null) {
        answers.add(answerResponse);
      } else {
        answer.x = answerResponse.x;
        answer.y = answerResponse.y;
        answer.answer = answerResponse.answer;
      }
    }

    if (i > 10) {
      i = 0;
      answers = [...answerResponses];
    }

    if (answerResponses.isNotEmpty) {
      setState(() {
        wImage = width;
        hImage = height;
      });
    } else {
      setState(() {
        wImage = 0;
      });
    }

    // summary answer

    // var scanProvider = Provider.of<ScanProvider>(context, listen: false);
    final choices = scanProvider.choices;
    for (final choice in choices) {
      choice.totalSelected = scanProvider.students
          .where((element) => element.answer == choice.id)
          .length;
    }
    scanProvider.setChoices(choices);
  }

  static Uint8List _concatenatePlanes(List<Plane> planes) {
    final allBytes = WriteBuffer();
    for (final plane in planes) {
      allBytes.putUint8List(plane.bytes);
    }
    return allBytes.done().buffer.asUint8List();
  }

  @override
  void dispose() {
    Screen.keepOn(false);
    controller?.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    scanProvider = Provider.of<ScanProvider>(context, listen: true);

    if (controller == null || !controller.value.isInitialized) {
      return Container();
    }
    return NativeDeviceOrientationReader(builder: (context) {
      // final orientation = NativeDeviceOrientationReader.orientation(context);
      // int turns;
      // switch (orientation) {
      //   case NativeDeviceOrientation.landscapeLeft:
      //     turns = -1;
      //     break;
      //   case NativeDeviceOrientation.landscapeRight:
      //     turns = 1;
      //     break;
      //   case NativeDeviceOrientation.portraitDown:
      //     turns = 2;
      //     break;
      //   default:
      //     turns = 0;
      //     break;
      // }
      return Scaffold(
        bottomNavigationBar: FTabBar(
            floatingButtonAction: FFloatingButtonAction(
                icon: FOutlinedIcons.check,
                onPressed: () async {
                  if (isSending) {
                    return;
                  }

                  await controller.dispose();
                  isSending = true;
                  try {
                    final task1 = saveAnswer();
                    final task2 = saveQuestion();
                    final task3 = sendMessageAnswer();
                    await Future.wait([task1, task2, task3]);

                    showAnswerSummary();
                    isSending = false;
                  } catch (e) {
                    isSending = false;
                    await onNewCameraSelected();
                  }
                }),
            floatingButtonActionPosition: FFloatingButtonActionPosition.center,
            children: [
              FTabBarItem(
                icon: FOutlinedIcons.bar_chart,
                onTap: (index) {
                  buildListAnswer();
                },
              ),
              FTabBarItem(
                icon: FOutlinedIcons.hat,
                onTap: (index) {
                  buildListStudent(
                    scanProvider.students,
                    scanProvider.question.dataResponse,
                  );
                },
              ),
            ]),
        body: Container(
          child: Stack(
            children: [
              CameraPreview(controller),

              // RotatedBox(
              //   quarterTurns: turns,
              //   child: Transform.scale(
              //     scale: 1 / controller.value.aspectRatio,
              //     child: Center(
              //       child: AspectRatio(
              //         aspectRatio: controller.value.aspectRatio,
              //         child: CameraPreview(controller),
              //       ),
              //     ),
              //   ),
              // ),
              CustomPaint(
                painter: DrawMarker(
                    // x: x_answer,
                    // y: y_answer,
                    hImage: hImage,
                    wImage: wImage,
                    answers: answers,
                    studentCard: studentCard,
                    question: scanProvider.question),
                child: Container(),
              ),
              buildInfo()
            ],
          ),
        ),
      );
    });
  }

  Future<void> sendMessageAnswer() async {
    if (widget.client == null) {
      return;
    }

    final builder = MqttClientPayloadBuilder();

    final data = <AnswerData>[];

    scanProvider.students
        .where((element) => element.answer != null)
        .forEach((element) {
      data.add(AnswerData(
          answer: int.parse(element.answer),
          itemId: scanProvider.question.id,
          studentId: element.id));
    });

    final jsonData = jsonEncode(data);
    builder.addString(
        '{"command": "update_student_answers", "student_answers":$jsonData,"presentation_id":${widget.presentId}, "device_id":"${await Utils.getDeviceId()}"}');

    final provider = Provider.of<PresentProvider>(context, listen: false);
    widget.client
        .publishMessage(provider.topic, MqttQos.atLeastOnce, builder.payload);
  }

  Future<void> saveAnswer() async {
    await presentDA.saveAnswer(
        scanProvider.students, scanProvider.question.id, widget.presentId);
  }

  Future<void> saveQuestion() async {
    final presentationProvider =
        Provider.of<PresentationProvider>(context, listen: false);
    final present = presentationProvider.presents.firstWhere(
      (element) => element.id == widget.presentId,
      orElse: () => null,
    );

    if (present != null) {
      if (!present.questionScanedIds.contains(scanProvider.question.id)) {
        present.questionScanedIds.add(scanProvider.question.id);
        await presentDA.saveQuestion(
            scanProvider.question.id, widget.presentId);
        presentationProvider.rebuild();
      }
    }
  }

  void showAnswerSummary() {
    showModalBottomSheet(
        context: context,
        backgroundColor: FColors.transparent,
        elevation: 0,
        enableDrag: false,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        builder: (context) => AnswerSummary(
              scanProvider.students,
              scanProvider.question,
              buildListStudent,
              widget.client,
              callBack: () {
                onNewCameraSelected();
              },
            ));
  }

  void buildListAnswer() {
    showModalBottomSheet(
        isScrollControlled: true,
        elevation: 0,
        isDismissible: true,
        enableDrag: true,
        backgroundColor: FColors.transparent,
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) => Container(
                child: FBottomSheet(
                  header: FModal(
                    title: const FText('Kết quả'),
                    textAction: FButton(
                      title: 'Done',
                      backgroundColor: FColors.transparent,
                      color: SkinColor.primary,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  body:
                      // Consumer<ScanProvider>(
                      //   builder: (context, scanProvider, _) =>
                      Container(
                    color: FColors.grey1,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: scanProvider.choices.length,
                        itemBuilder: (context, index) {
                          final sameAnswer = <StudentItem>[];
                          final choicesItem = scanProvider.choices[index];
                          for (final element in scanProvider.students) {
                            if (element.answer ==
                                scanProvider.choices[index].id) {
                              sameAnswer.add(element);
                            }
                          }
                          return Container(
                            margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
                            padding: EdgeInsets.only(left: 24.w, right: 24.w),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Html(
                                        data: scanProvider
                                            .choices[index].choiceName
                                            .trim(),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        FText(
                                          '${choicesItem.totalSelected}',
                                          style: FTextStyle.subtitle2,
                                          color: FColors.blue6,
                                        ),
                                        scanProvider.choices[index]
                                                    .totalSelected >
                                                0
                                            ? Container(
                                                margin:
                                                    // ignore: lines_longer_than_80_chars
                                                    const EdgeInsets.only(
                                                        left: 4),
                                                child: FIcon(
                                                  icon: FOutlinedIcons.right,
                                                  onPressed: () {
                                                    buildListStudent(
                                                        sameAnswer,
                                                        scanProvider.question
                                                            .dataResponse);
                                                  },
                                                ),
                                              )
                                            : Container()
                                      ],
                                    ),
                                  ],
                                ),
                                FSpacer.space8px,
                                LinearProgressIndicator(
                                  value: scanProvider
                                          .choices[index].totalSelected /
                                      scanProvider.students.length,
                                  backgroundColor: FColors.grey4,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      scanProvider.choices[index].id ==
                                              scanProvider.question.dataResponse
                                          ? FColors.blue6
                                          : FColors.red6),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ),
                //   ),
              ),
            ));
  }

  void buildListStudent(List<StudentItem> students, String dataResponse) {
    showModalBottomSheet(
        isScrollControlled: true,
        elevation: 0,
        isDismissible: true,
        enableDrag: true,
        backgroundColor: FColors.transparent,
        context: context,
        builder: (context) => Container(
              margin: const EdgeInsets.only(top: 32),
              color: FColors.transparent,
              child: FBottomSheet(
                header: const FModal(
                  title: FText('Danh sách thí sinh'),
                ),
                body: Expanded(
                  child: Container(
                    color: FColors.grey1,
                    child: Consumer<ScanProvider>(
                        builder: (context, scanProvider, _) => Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: ListStudentAnswer(students, dataResponse),
                            )),
                  ),
                ),
              ),
            ));
  }

  Widget buildInfo() => Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 32,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  padding: const EdgeInsets.fromLTRB(9, 4, 10, 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: FColors.grey10),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 4),
                        child: FBoundingBox(
                          size: FBoxSize.size8x8,
                          backgroundColor: FColors.green6,
                          type: FBoundingBoxType.circle,
                          child: Container(),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        child: FText('${scanProvider.totalTrue()}',
                            style: FTextStyle.titleModules6,
                            color: FColors.grey1,
                            textAlign: TextAlign.justify,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 32,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  padding: const EdgeInsets.fromLTRB(9, 4, 10, 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: FColors.grey10),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 4),
                        child: FBoundingBox(
                          size: FBoxSize.size8x8,
                          backgroundColor: FColors.red6,
                          type: FBoundingBoxType.circle,
                          child: Container(),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        child: FText('${scanProvider.totalFalse()}',
                            style: FTextStyle.titleModules6,
                            color: FColors.grey1,
                            textAlign: TextAlign.justify,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 32,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  padding: const EdgeInsets.fromLTRB(9, 4, 10, 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: FColors.grey10),
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        child: FText(
                            '${scanProvider.answered()}/${scanProvider.students.length}',
                            style: FTextStyle.titleModules6,
                            color: FColors.grey1,
                            textAlign: TextAlign.justify,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}
