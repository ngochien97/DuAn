import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TakerGroups/bloc/student_detail/student_detail_bloc.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TakerGroups/bloc/student_detail/student_detail_state.dart';
import 'package:khao_thi_gv/FIS.SYS/Skins/KhaoThi/SkinColor.dart';

import '../../../../F.Utils/Convert.dart';
import '../../../Components/ComponentsBase.dart';
import '../../../Skins/Typography.dart';
import '../../../Styles/StyleBase.dart';
import '../StudentAnswerItem.dart';

class AnswerList extends StatefulWidget {
  final List<StudentAnswerItem> studentAnswers;
  final List<StudentAnswerItem> childrenItemAnswer;
  final ScrollController scrollController;

  const AnswerList(
      this.studentAnswers, this.childrenItemAnswer, this.scrollController);
  @override
  _AnswerListState createState() => _AnswerListState();
}

class _AnswerListState extends State<AnswerList> {
  int indexItem = 0;

  Widget answerChoice({
    String answer,
    dynamic content,
    int index,
    String rightAnswer,
    StudentAnswerItem item,
  }) {
    Color backgroundColor;
    Color borderColor;

    if (answer == rightAnswer && answer == '$index') {
      backgroundColor = FColors.green6;
    } else if (answer != rightAnswer && answer == '$index') {
      backgroundColor = FColors.red6;
    } else {
      backgroundColor = FColors.transparent;
    }

    if (rightAnswer == '$index') {
      borderColor = FColors.green6;
    } else if (answer != rightAnswer && answer == '$index') {
      borderColor = FColors.red6;
    } else {
      borderColor = FColors.grey4;
    }

    return FListTitle(
      backgroundColor: FColors.transparent,
      title: Container(
        child: Row(
          children: [
            FBoundingBox(
              backgroundColor: backgroundColor,
              type: item != null && item.type == 2
                  ? FBoundingBoxType.square
                  : FBoundingBoxType.circle,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  border: Border.all(color: borderColor),
                  borderRadius: item != null && item.type == 2
                      ? null
                      : BorderRadius.circular(12),
                ),
                child: FText(
                  index.toAlphabet(),
                  textAlign: TextAlign.center,
                  style: FTextStyle.titleModules6,
                  color: answer == '$index' ? FColors.grey1 : FColors.grey8,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 8),
                child: Html(
                  data: content,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemsChildren(StudentAnswerItem item) {
    return Column(
      children: [
        Wrap(
          children: [
            Html(
              data: item.body,
              style: {
                'html': Style(fontFamily: 'Roboto', fontSize: FontSize.medium)
              },
            ),
          ],
        ),
        item.markRubric != null
            ? Container()
            : Container(
                margin: EdgeInsets.only(top: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    answerChoice(
                        answer: '${item.answer}',
                        content: '${item.choices.s1}',
                        index: 1,
                        item: item,
                        rightAnswer: '${item.response}'),
                    answerChoice(
                        answer: '${item.answer}',
                        content: '${item.choices.s2}',
                        index: 2,
                        item: item,
                        rightAnswer: '${item.response}'),
                    answerChoice(
                        answer: '${item.answer}',
                        content: '${item.choices.s3}',
                        index: 3,
                        item: item,
                        rightAnswer: '${item.response}'),
                    answerChoice(
                        answer: '${item.answer}',
                        content: '${item.choices.s4}',
                        index: 4,
                        item: item,
                        rightAnswer: '${item.response}'),
                  ],
                ),
              ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.fromLTRB(8, 0, 8, 24),
        child: ListView.builder(
          controller: widget.scrollController,
          physics: BouncingScrollPhysics(),
          itemCount: widget.studentAnswers.length,
          scrollDirection: Axis.horizontal,
          cacheExtent: 999999999,
          itemBuilder: (context, index) {
            final element = widget.studentAnswers[index];
            final listChildren = widget.childrenItemAnswer
                .where((e) => e.parentId == element.id)
                .toList();

            return AnswerItem(
                element,
                listChildren,
                widget.studentAnswers.length +
                    widget.childrenItemAnswer.length -
                    widget.studentAnswers
                        .where((element) => element.isParent == 1)
                        .length);
          },
        ),
      );
}

class AnswerItem extends StatefulWidget {
  StudentAnswerItem answerItem;
  int totalAnswer;
  final List<StudentAnswerItem> childrenItemAnswer;
  AnswerItem(this.answerItem, this.childrenItemAnswer, this.totalAnswer,
      {Key key})
      : super(key: key);

  @override
  _AnswerItemState createState() => _AnswerItemState();
}

class _AnswerItemState extends State<AnswerItem>
    with SingleTickerProviderStateMixin {
  int indexItem = 0;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(vsync: this, length: widget.childrenItemAnswer.length);
  }

  @override
  Widget build(BuildContext context) {
    final tabView = <Tab>[];
    for (var i = 0; i < widget.childrenItemAnswer.length; i++) {
      tabView.add(Tab(
        text:
            '${widget.answerItem.index}.${(i + 1).toAlphabet().toLowerCase()}',
      ));
    }

    return BlocConsumer<StudentDetailScrollParentBloc, StudentDetailState>(
      listener: (context, state) {
        if (widget.answerItem.isParent == 1) {
          _tabController.animateTo(state.tabIndex);
        }
      },
      builder: (context, state) {
        return Container(
          height: 550,
          width: MediaQuery.of(context).size.width * 0.82,
          margin: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: FColors.grey1,
              boxShadow: [FEffect.elevation1]),
          child: Container(
            height: 550,
            child: Scaffold(
              backgroundColor: FColors.transparent,
              appBar: FAppBar(
                headerLead: Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      FText(
                        '${widget.answerItem.index + indexItem}',
                        style: FTextStyle.titleModules4,
                      ),
                      FText(
                        ' / ${widget.totalAnswer}',
                        style: FTextStyle.titleModules4,
                        color: FColors.grey6,
                      )
                    ],
                  ),
                ),
              ),
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: [
                      Wrap(
                        children: [
                          Html(
                            data: widget.answerItem.body,
                            style: {
                              'html': Style(
                                  fontFamily: 'Roboto',
                                  fontSize: FontSize.medium)
                            },
                          ),
                        ],
                      ),
                      widget.answerItem.isParent == 1
                          ? Container(
                              child: Column(
                                children: [
                                  FDivider(),
                                  Container(
                                    child: DefaultTabController(
                                      length: widget.childrenItemAnswer.length,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            physics: BouncingScrollPhysics(),
                                            child: Container(
                                              width: (62 * tabView.length)
                                                  .toDouble(),
                                              alignment: Alignment.centerLeft,
                                              child: TabBar(
                                                controller: _tabController,
                                                onTap: (index) {
                                                  setState(() {
                                                    indexItem = index;
                                                  });
                                                },
                                                tabs: tabView,
                                                indicatorColor:
                                                    SkinColor.primary,
                                                labelColor: FColors.grey9,
                                                labelStyle: CustomFont
                                                    .regular14_22
                                                    .copyWith(
                                                        color: FColors.grey9),
                                                indicator:
                                                    UnderlineTabIndicator(
                                                  borderSide: BorderSide(
                                                      color: FColors.grey9),
                                                ),
                                                unselectedLabelStyle: CustomFont
                                                    .regular14_22
                                                    .copyWith(
                                                        color: FColors.grey6),
                                                unselectedLabelColor:
                                                    FColors.grey6,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 8),
                                            color: FColors.grey1,
                                            height: 500,
                                            child: TabBarView(
                                              controller: _tabController,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              children: [
                                                for (final e in widget
                                                    .childrenItemAnswer)
                                                  itemsChildren(e)
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Container(),
                      widget.answerItem.isParent == 1
                          ? Container()
                          : Container(
                              margin: EdgeInsets.only(top: 40),
                              child: widget.answerItem.type == 3
                                  ? Html(
                                      data: getHtmlAnswer(
                                          widget.answerItem.answer),
                                      style: {
                                        'html': Style(
                                            fontFamily: 'Roboto',
                                            fontSize: FontSize.medium)
                                      },
                                    )
                                  : Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (widget.answerItem.choices.s1 !=
                                                null &&
                                            widget.answerItem.choices.s1 != '')
                                          answerChoice(
                                              answer:
                                                  '${widget.answerItem.answer}',
                                              content:
                                                  '${widget.answerItem.choices.s1}',
                                              index: 1,
                                              item: widget.answerItem,
                                              rightAnswer:
                                                  '${widget.answerItem.response}'),
                                        if (widget.answerItem.choices.s2 !=
                                                null &&
                                            widget.answerItem.choices.s2 != '')
                                          answerChoice(
                                              answer:
                                                  '${widget.answerItem.answer}',
                                              content:
                                                  '${widget.answerItem.choices.s2}',
                                              index: 2,
                                              item: widget.answerItem,
                                              rightAnswer:
                                                  '${widget.answerItem.response}'),
                                        if (widget.answerItem.choices.s3 !=
                                                null &&
                                            widget.answerItem.choices.s3 != '')
                                          answerChoice(
                                              answer:
                                                  '${widget.answerItem.answer}',
                                              content:
                                                  '${widget.answerItem.choices.s3}',
                                              index: 3,
                                              item: widget.answerItem,
                                              rightAnswer:
                                                  '${widget.answerItem.response}'),
                                        if (widget.answerItem.choices.s4 !=
                                                null &&
                                            widget.answerItem.choices.s4 != '')
                                          answerChoice(
                                              answer:
                                                  '${widget.answerItem.answer}',
                                              content:
                                                  '${widget.answerItem.choices.s4}',
                                              index: 4,
                                              item: widget.answerItem,
                                              rightAnswer:
                                                  '${widget.answerItem.response}'),
                                      ],
                                    ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String getHtmlAnswer(String txt) {
    if (txt != null) {
      final temp = json.decode(txt);
      return temp['content'];
    }
    return '';
  }

  Widget itemsChildren(StudentAnswerItem item) {
    return Column(
      children: [
        Wrap(
          children: [
            Html(
              data: item.body,
              style: {
                'html': Style(fontFamily: 'Roboto', fontSize: FontSize.medium)
              },
            ),
          ],
        ),
        item.markRubric != null
            ? Container()
            : Container(
                margin: EdgeInsets.only(top: 8),
                child: item.type == 3
                    ? Html(
                        data: getHtmlAnswer(item.answer),
                        style: {
                          'html': Style(
                              fontFamily: 'Roboto', fontSize: FontSize.medium)
                        },
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (item.choices.s1 != null && item.choices.s1 != '')
                            answerChoice(
                                answer: '${item.answer}',
                                content: '${item.choices.s1}',
                                index: 1,
                                rightAnswer: '${item.response}'),
                          if (item.choices.s2 != null && item.choices.s2 != '')
                            answerChoice(
                                answer: '${item.answer}',
                                content: '${item.choices.s2}',
                                index: 2,
                                rightAnswer: '${item.response}'),
                          if (item.choices.s3 != null && item.choices.s3 != '')
                            answerChoice(
                                answer: '${item.answer}',
                                content: '${item.choices.s3}',
                                index: 3,
                                rightAnswer: '${item.response}'),
                          if (item.choices.s4 != null && item.choices.s4 != '')
                            answerChoice(
                                answer: '${item.answer}',
                                content: '${item.choices.s4}',
                                index: 4,
                                rightAnswer: '${item.response}'),
                        ],
                      ),
              ),
      ],
    );
  }

  Widget answerChoice({
    String answer,
    dynamic content,
    int index,
    String rightAnswer,
    StudentAnswerItem item,
  }) {
    Color backgroundColor;
    Color borderColor;

    if (answer == rightAnswer && answer == '$index') {
      backgroundColor = FColors.green6;
    } else if (answer != rightAnswer && answer == '$index') {
      backgroundColor = FColors.red6;
    } else {
      backgroundColor = FColors.transparent;
    }

    if (rightAnswer == '$index') {
      borderColor = FColors.green6;
    } else if (answer != rightAnswer && answer == '$index') {
      borderColor = FColors.red6;
    } else {
      borderColor = FColors.grey4;
    }

    return FListTitle(
      backgroundColor: FColors.transparent,
      title: Container(
        child: Row(
          children: [
            FBoundingBox(
              backgroundColor: backgroundColor,
              type: item != null && item.type == 2
                  ? FBoundingBoxType.square
                  : FBoundingBoxType.circle,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  border: Border.all(color: borderColor),
                  borderRadius: item != null && item.type == 2
                      ? null
                      : BorderRadius.circular(12),
                ),
                child: FText(
                  index.toAlphabet(),
                  textAlign: TextAlign.center,
                  style: FTextStyle.titleModules6,
                  color: answer == '$index' ? FColors.grey1 : FColors.grey8,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 8),
                child: Html(
                  data: content,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
