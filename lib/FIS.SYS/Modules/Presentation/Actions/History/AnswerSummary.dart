import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../F.Utils/SrceenExtensions.dart';
import '../../../../Components/ComponentsBase.dart';
import '../../../../Skins/Icon.dart';
import '../../../../Skins/Typography.dart';
import '../../../../Styles/StyleBase.dart';
import '../../../Students/StudentItem.dart';
import '../../AnswerPresentation.dart';
import '../../DA/PresentDA.dart';
import '../../PresentationItem.dart';
import '../../Providers/ScanProvider.dart';
import '../ListStudentAnswer.dart';

class AnswerSummaryHistory extends StatefulWidget {
  final List<StudentItem> students;

  final MqttServerClient client;
  final PresentationItem present;
  final int currentIdex;

  const AnswerSummaryHistory(
      this.students, this.currentIdex, this.client, this.present);

  @override
  _StartPresentationScreenState createState() =>
      _StartPresentationScreenState();
}

class _StartPresentationScreenState extends State<AnswerSummaryHistory> {
  PresentationItem present;
  int currentIdex;
  String topic;
  bool isLoading = true;

  PresentDA presentDA = PresentDA();
  List<AnswerPresentation> answers = [];

  @override
  void initState() {
    super.initState();
    present = widget.present;
    currentIdex = widget.currentIdex;
    loadAnswer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void loadAnswer() {
    presentDA.getAnswer(present.testTakerGroupId).then((data) {
      if (data.code != 200) {
        setState(() {
          isLoading = false;
        });
      }

      answers = data.answers;

      present.items.forEach((questionsItem) {
        final answer = data.answers.firstWhere(
          (element) => element.itemId == questionsItem.id,
          orElse: () => null,
        );
        if (answer != null) {
          for (final choice in questionsItem.choices) {
            choice.totalSelected = answer.answers
                .where((element) => element.answer == choice.id)
                .length;
          }
          // for (final student in widget.students) {
          //   final studentAnswer = answer.answers.firstWhere(
          //     (element) => element.studentId == student.id,
          //     orElse: () => null,
          //   );
          //   if (studentAnswer == null) {
          //     student.answer = null;
          //   } else {
          //     student.answer = studentAnswer.answer;
          //   }
          // }
        }
      });
      setStudentAnswer();

      setState(() {
        isLoading = false;
      });
    }).whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
  }

  void setStudentAnswer() {
    final answer = answers.firstWhere(
      (element) => element.itemId == present.items[currentIdex].id,
      orElse: () => null,
    );
    if (answer != null) {
      for (final student in widget.students) {
        final studentAnswer = answer.answers.firstWhere(
          (element) => element.studentId == student.id,
          orElse: () => null,
        );
        if (studentAnswer == null) {
          student.answer = null;
        } else {
          student.answer = studentAnswer.answer;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            },
          ),
          textAction: Container(
            width: 48.0,
            child: RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: '${currentIdex + 1}',
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
              child: isLoading
                  ? Loading()
                  : SingleChildScrollView(
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
                              data: present.items[currentIdex].dataBodyHtml,
                            ),
                          ),
                          Consumer<ScanProvider>(
                            builder: (context, value, child) => Container(
                                margin: EdgeInsets.only(bottom: 16.0),
                                alignment: Alignment.topLeft,
                                child: Column(
                                  children: [
                                    for (final element
                                        in present.items[currentIdex].choices)
                                      GestureDetector(
                                        onTap: () {
                                          buildListStudentAnswer(
                                              widget.students
                                                  .where((student) =>
                                                      student.answer ==
                                                      element.id)
                                                  .toList(),
                                              present.items[currentIdex]
                                                  .dataResponse);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              top: 8.h, bottom: 8.h),
                                          padding: EdgeInsets.only(
                                              left: 24.w, right: 24.w),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Html(
                                                      data: element.choiceName
                                                          .trim(),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      FText(
                                                        '${element.totalSelected}',
                                                        style: FTextStyle
                                                            .subtitle2,
                                                        color: FColors.blue6,
                                                      ),
                                                      element.totalSelected > 0
                                                          ? Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 4),
                                                              child: FIcon(
                                                                icon:
                                                                    FOutlinedIcons
                                                                        .right,
                                                                onPressed:
                                                                    () {},
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
                                                    widget.students.length,
                                                backgroundColor: FColors.grey4,
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(element.id ==
                                                            present
                                                                .items[
                                                                    currentIdex]
                                                                .dataResponse
                                                        ? FColors.blue6
                                                        : FColors.red6),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                )),
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
                            FButton(
                              title: 'Xem',
                              onPressed: () {
                                buildListStudentAnswer(widget.students,
                                    present.items[currentIdex].dataResponse);
                              },
                              backgroundColor: FColors.transparent,
                              block: true,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              color: FColors.blue6,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                FTabBar(
                    elevation: 8,
                    floatingButtonAction: FFloatingButtonAction(
                        backgroundColor: FColors.grey6,
                        border: Border.all(width: 4, color: FColors.grey3),
                        icon: FFilledIcons.video_camera,
                        onPressed: () {}),
                    floatingButtonActionPosition:
                        FFloatingButtonActionPosition.center,
                    children: [
                      FTabBarItem(
                        icon: FFilledIcons.step_backward,
                        color: currentIdex == 0
                            ? FColors.transparent
                            : FColors.blue6,
                        onTap: (index) async {
                          if (currentIdex != 0) {
                            await changeSlide(currentIdex - 1);
                          }
                        },
                      ),
                      FTabBarItem(
                        icon: FFilledIcons.step_forward,
                        color: currentIdex < present.items.length - 1
                            ? FColors.blue6
                            : FColors.transparent,
                        onTap: (index) async {
                          if (currentIdex < present.items.length - 1) {
                            await changeSlide(currentIdex + 1);
                          }
                        },
                      ),
                    ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> changeSlide(int index) async {
    setState(() {
      currentIdex = index;
    });
    setStudentAnswer();
  }

  void buildListStudentAnswer(List<StudentItem> students, String dataResponse) {
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
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: ListStudentAnswer(students, dataResponse),
                    ),
                  ),
                ),
              ),
            ));
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        enabled: true,
        child: ListView.builder(
          itemBuilder: (_, __) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48.0,
                  height: 48.0,
                  color: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: 40.0,
                        height: 8.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          itemCount: 6,
        ),
      ),
    );
  }
}
