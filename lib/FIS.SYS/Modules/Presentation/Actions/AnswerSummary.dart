import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:provider/provider.dart';

import '../../../../F.Utils/SrceenExtensions.dart';
import '../../../../F.Utils/Utils.dart';
import '../../../Components/ComponentsBase.dart';
import '../../../Skins/Icon.dart';
import '../../../Skins/Typography.dart';
import '../../../Styles/StyleBase.dart';
import '../../Students/StudentItem.dart';
import '../DA/PresentDA.dart';
import '../PresentationItem.dart';
import '../Providers/PresentProvider.dart';
import '../Providers/ScanProvider.dart';
import '../Question.dart';
import 'ListStudentAnswer.dart';

class AnswerSummary extends StatefulWidget {
  final List<StudentItem> students;
  final Question question;
  final Function showListStudent;
  final MqttServerClient client;
  final void Function() callBack;

  const AnswerSummary(
      this.students, this.question, this.showListStudent, this.client,
      {this.callBack});

  @override
  _StartPresentationScreenState createState() =>
      _StartPresentationScreenState();
}

class _StartPresentationScreenState extends State<AnswerSummary> {
  List<StudentItem> students;
  Question question;
  PresentationItem present;
  PresentProvider provider;
  bool isShowAnswer = false;
  @override
  void initState() {
    super.initState();
    provider = Provider.of<PresentProvider>(context, listen: false);
    question = widget.question;
    present = provider.present;
    students = widget.students;
    // ignore: avoid_function_literals_in_foreach_calls
    question.choices.forEach((choice) {
      choice.totalSelected =
          students.where((element) => element.answer == choice.id).length;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        color: FColors.transparent,
        margin: const EdgeInsets.only(top: 32.0),
        child: FBottomSheet(
          header: FModal(
            title: Container(),
            iconAction: FIconButton(
              icon: FOutlinedIcons.close,
              color: FColors.grey9,
              size: FIconButtonSize.size48,
              backgroundColor: FColors.transparent,
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
                if (widget.callBack != null) {
                  widget.callBack();
                }
              },
            ),
            textAction: Container(
              width: 48.0,
              child: RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: '${provider.currentIdex + 1}',
                      style: const TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                          color: FColors.grey9)),
                  TextSpan(
                      text: ' / ${present.items.length}',
                      style:
                          const TextStyle(fontSize: 17.0, color: FColors.grey4))
                ]),
              ),
            ),
          ),
          body: Expanded(
            child: Scaffold(
              backgroundColor: FColors.grey1,
              body: Container(
                margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        child: Html(
                          style: {
                            'html': Style(
                                fontFamily: 'Roboto',
                                textAlign: TextAlign.left,
                                margin: EdgeInsets.all(0)),
                            'img': Style(),
                          },
                          data: question.dataBodyHtml,
                        ),
                      ),
                      Consumer<ScanProvider>(
                        builder: (context, value, child) => Container(
                            margin: EdgeInsets.only(bottom: 16.0),
                            alignment: Alignment.topLeft,
                            child: Column(
                              children: [
                                for (final element in question.choices)
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 8.h, bottom: 8.h),
                                    padding: EdgeInsets.only(
                                        left: 24.w, right: 24.w),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Html(
                                                data: element.choiceName.trim(),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                FText(
                                                  '${element.totalSelected}',
                                                  style: FTextStyle.subtitle2,
                                                  color: FColors.blue6,
                                                ),
                                                element.totalSelected > 0
                                                    ? Container(
                                                        margin: const EdgeInsets
                                                            .only(left: 4),
                                                        child: FIcon(
                                                          icon: FOutlinedIcons
                                                              .right,
                                                          onPressed: () {
                                                            final sameAnswer =
                                                                <StudentItem>[];
                                                            for (final e
                                                                in students) {
                                                              if (e.answer ==
                                                                  element.id) {
                                                                sameAnswer
                                                                    .add(e);
                                                              }
                                                            }
                                                            widget.showListStudent(
                                                                sameAnswer,
                                                                question
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
                                          value: element.totalSelected /
                                              students.length,
                                          backgroundColor: FColors.grey4,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  !isShowAnswer
                                                      ? FColors.grey7
                                                      : element.id ==
                                                              question
                                                                  .dataResponse
                                                          ? FColors.blue6
                                                          : FColors.red6),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            )
                            // ListView.builder(
                            //     shrinkWrap: true,
                            //     itemCount: .length,
                            //     itemBuilder: (context, index) =>

                            //       ),
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 24.h),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              FText(
                                '${students.where((element) => element.answer == null).length}',
                                style: FTextStyle.bodyText1,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.center,
                              ),
                              FText(
                                'Chưa trả lời',
                                textAlign: TextAlign.center,
                              ),
                              FButton(
                                title: 'Xem',
                                onPressed: () {
                                  buildListStudentNoAnswer();
                                },
                                backgroundColor: FColors.transparent,
                                block: true,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                color: FColors.blue6,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            FButton(
                              title: !isShowAnswer
                                  ? 'Hiện thị đáp án'
                                  : 'Ẩn đáp án',
                              onPressed: () {
                                setState(() {
                                  isShowAnswer = !isShowAnswer;
                                });
                              },
                              backgroundColor: FColors.transparent,
                              color: FColors.blue6,
                            ),
                            FButton(
                              title: 'Làm mới',
                              onPressed: () async {
                                final presentDA = PresentDA();
                                await presentDA.resetAnwer(
                                    present.id, question.id);
                                Provider.of<ScanProvider>(context,
                                        listen: false)
                                    .resetAnswer();
                                final builder = MqttClientPayloadBuilder();
                                builder.addString(
                                    '{"command": "update_student_answers", "student_answers":[],"presentation_id":${present.id}, "device_id":"${await Utils.getDeviceId()}"}');

                                widget.client.publishMessage(provider.topic,
                                    MqttQos.atLeastOnce, builder.payload);
                              },
                              backgroundColor: FColors.transparent,
                              color: FColors.blue6,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  FTabBar(
                      elevation: 8,
                      floatingButtonAction: FFloatingButtonAction(
                          border: Border.all(width: 4, color: FColors.grey3),
                          icon: FFilledIcons.video_camera,
                          onPressed: () {
                            Navigator.of(context).pop();
                            if (widget.callBack != null) {
                              widget.callBack();
                            }
                          }),
                      floatingButtonActionPosition:
                          FFloatingButtonActionPosition.center,
                      children: [
                        FTabBarItem(
                          icon: FFilledIcons.step_backward,
                          color: provider.currentIdex == 0
                              ? FColors.transparent
                              : FColors.grey6,
                          onTap: (index) async {
                            if (provider.currentIdex != 0) {
                              await changeSlide(
                                  provider.currentIdex - 1, provider);
                            }
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                        ),
                        FTabBarItem(
                          icon: FFilledIcons.step_forward,
                          color: provider.currentIdex < present.items.length - 1
                              ? FColors.grey6
                              : FColors.transparent,
                          onTap: (index) async {
                            if (provider.currentIdex <
                                present.items.length - 1) {
                              await changeSlide(
                                  provider.currentIdex + 1, provider);
                            }
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                        ),
                      ]),
                ],
              ),
            ),
          ),
        ),
      );

  Future<void> changeSlide(int index, PresentProvider provider) async {
    final builder = MqttClientPayloadBuilder();

    builder.addString(
        '{"command": "change_slide","presentation_id":${provider.present.id}, "slide_num":$index,"device_id":"${await Utils.getDeviceId()}"}');

    widget.client
        .publishMessage(provider.topic, MqttQos.atLeastOnce, builder.payload);
    provider.changeQuestion(index);
    final scanProvider = Provider.of<ScanProvider>(context, listen: false);
    await scanProvider.init(
        provider.present, provider.currentQuestion, scanProvider.students);
  }

  void buildListStudentNoAnswer() {
    showModalBottomSheet(
        isScrollControlled: true,
        elevation: 0,
        isDismissible: true,
        enableDrag: true,
        backgroundColor: FColors.transparent,
        context: context,
        builder: (context) => Container(
              margin: EdgeInsets.only(top: 32),
              color: FColors.transparent,
              child: FBottomSheet(
                header: FModal(
                  title: FText('Danh sách thí sinh'),
                ),
                body: Expanded(
                  child: Container(
                    color: FColors.grey1,
                    child: Consumer<ScanProvider>(
                        builder: (context, scanProvider, _) {
                      final students = scanProvider.students
                          .where((element) => element.answer == null)
                          .toList();
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: ListStudentAnswer(
                            students, scanProvider.question.dataResponse),
                      );
                    }),
                  ),
                ),
              ),
            ));
  }
}
