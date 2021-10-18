import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khao_thi_gv/F.Utils/StaticNumber.dart';

import 'package:khao_thi_gv/F.Utils/Utils.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TakerGroups/bloc/student_detail/student_detail_bloc.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TakerGroups/bloc/student_detail/student_detail_event.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TakerGroups/bloc/student_detail/student_detail_state.dart';

// import '../../F.Utils/Convert.dart';
import '../../FIS.SYS/Components/ComponentsBase.dart';
import '../../FIS.SYS/Modules/Students/Actions/AnswerList.dart';
import '../../FIS.SYS/Modules/Students/AnswerChoiceItem.dart';
import '../../FIS.SYS/Modules/Students/StudentAnswerItem.dart';
import '../../FIS.SYS/Modules/Students/StudentDetailDA.dart';
import '../../FIS.SYS/Modules/Students/StudentItem.dart';
import '../../FIS.SYS/Modules/Students/TestFormItem.dart';
import '../../FIS.SYS/Skins/KhaoThi/SkinColor.dart';
import '../../FIS.SYS/Skins/Typography.dart';
import '../../FIS.SYS/Styles/StyleBase.dart';
import 'M.3.8_Chi_tiet_bai_lam.dart';

class StudentDetailScreen extends StatefulWidget {
  final int studentId;
  final String studentName;
  const StudentDetailScreen(this.studentId, this.studentName);
  @override
  _StudentDetailScreenState createState() => _StudentDetailScreenState();
}

class _StudentDetailScreenState extends State<StudentDetailScreen> {
  ScrollController scrollController = ScrollController();
  bool checkData;
  bool isloading = true;
  List<Tab> tabView = [
    const Tab(
      text: 'Bài làm',
    ),
    // const Tab(
    //   text: 'Đánh giá',
    // ),
    // const Tab(text: 'Biểu đồ')
  ];

  StudentItem studentItem = StudentItem(
    testFormCode: '',
    code: '',
    className: '',
    score: '0.00',
    point: '0',
    totalPoint: '0',
  );
  TestFormItem testFormItem = TestFormItem(timeLimit: 0);
  List<StudentAnswerItem> listStudentAnswerItems = [
    StudentAnswerItem(
      answer: '',
      body: '',
      choices: AnswerChoice(s1: '', s2: '', s3: '', s4: ''),
      response: '',
    ),
  ];
  List<StudentAnswerItem> listChildrenItem = [
    StudentAnswerItem(
      answer: '',
      body: '',
      choices: AnswerChoice(s1: '', s2: '', s3: '', s4: ''),
      response: '',
    ),
  ];

  Widget question({StudentAnswerItem answerItem, int index, int currentIndex}) {
    Color color;
    Color borderColor;
    if (answerItem.answer == null || answerItem.answer == '') {
      color = FColors.grey7;
      borderColor = FColors.grey4;
    } else if (answerItem.statusAnswer == true) {
      color = FColors.green6;
      borderColor = FColors.green6;
    } else if (answerItem.answer != '' &&
        answerItem.answer != null &&
        answerItem.statusAnswer == false) {
      color = FColors.red6;
      borderColor = FColors.red6;
    }

    return FBoundingBox(
      backgroundColor:
          index != currentIndex + 1 ? FColors.transparent : FColors.grey7,
      size: FBoxSize.size32x32,
      type: FBoundingBoxType.circle,
      child: Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(16),
        ),
        child: FText(
          '$index',
          textAlign: TextAlign.center,
          style: FTextStyle.titleModules6,
          color: color,
        ),
      ),
    );
  }

  Future<void> getData() async {
    final studentDetailDA = StudentDetailDA();
    try {
      final data = await studentDetailDA.getStudentDetail(widget.studentId);
      var index = 1;
      for (var parentIndex = 0;
          parentIndex < data.listStudentAnswerItem.length;
          parentIndex++) {
        final parent = data.listStudentAnswerItem[parentIndex];
        if (parent.isParent != 1) {
          parent.index = index++;
          parent.parentIndex = parentIndex + 1;
        } else {
          parent.index = index;
          final children = data.listChildrenItem
              .where((element) => element.parentId == parent.id)
              .toList();
          parent.children = children;
          for (var childIndex = 0; childIndex < children.length; childIndex++) {
            final child = children[childIndex];
            child.index = index++;
            child.parentIndex = parentIndex + 1;
          }
        }
      }
      setState(() {
        checkData = true;
        studentItem = data.studentItem;
        testFormItem = data.testFormItem;
        listStudentAnswerItems = data.listStudentAnswerItem;
        listChildrenItem = data.listChildrenItem;
        isloading = false;
      });
    } catch (e) {
      Utils.console(e);
      isloading = false;
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final listStudentInfor = <Map<String, dynamic>>[
      {'title': 'Mã đề:', 'content': '${studentItem.testFormCode ?? "-"}'},
      {'title': 'Mã dự thi:', 'content': '${studentItem.code ?? "-"}'},
      {'title': 'Thời gian:', 'content': '${testFormItem.timeLimit ?? "-"}'},
      {
        'title': 'Bắt đầu làm bài lúc:',
        'content': studentItem.startedAt != null
            ? '${studentItem.startedAt.hour} : ${studentItem.startedAt.minute}'
            : '00 : 00'
      },
      {
        'title': 'Nộp bài lúc:',
        'content': studentItem.submittedAt != null
            ? '${studentItem.submittedAt.hour} : ${studentItem.submittedAt.minute}'
            : '00 : 00'
      },
    ];
    return MultiBlocProvider(
      providers: [
        BlocProvider<StudentDetailBloc>(
          create: (BuildContext context) =>
              StudentDetailBloc(ScrollState(0, 0)),
        ),
        BlocProvider<StudentDetailScrollParentBloc>(
          create: (BuildContext context) =>
              StudentDetailScrollParentBloc(ScrollState(0, 0)),
        ),
      ],
      child: Container(
        margin: const EdgeInsets.only(top: 32),
        child: FBottomSheet(
          header: FModal(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FText(
                  '${widget.studentName}',
                  style: FTextStyle.titleModules5,
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: '${studentItem.className ?? ""} - ',
                        style: CustomFont.regular12_16
                            .copyWith(color: FColors.grey7)),
                    TextSpan(
                        text:
                            '${studentItem.score.substring(0, 4) ?? ""} Điểm (${studentItem.correctAnswerCount ?? ""}/${studentItem.totalItem ?? ""} câu)',
                        style: CustomFont.regular12_16
                            .copyWith(color: FColors.green7)),
                  ]),
                ),
              ],
            ),
          ),
          body: Expanded(
            child: Stack(
              children: [
                isloading
                    ? Scaffold(
                        body: StaticNumber.baseShimmer,
                      )
                    : Scaffold(
                        body: Container(
                          color: FColors.grey3,
                          padding: const EdgeInsets.only(top: 17),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                for (var element in listStudentInfor)
                                  FListTitle(
                                    dividerIndent: true,
                                    round: false,
                                    title: FText(
                                      element['title'],
                                      style: FTextStyle.subtitle2,
                                    ),
                                    action: [
                                      FText(
                                        element['content'],
                                      )
                                    ],
                                  ),
                                ListParent(
                                    listStudentAnswerItems, listChildrenItem),
                              ],
                            ),
                          ),
                        ),
                        bottomNavigationBar: ListFooter(
                            listStudentAnswerItems, listChildrenItem),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListParent extends StatefulWidget {
  final List<StudentAnswerItem> listChildrenItem;
  final List<StudentAnswerItem> listStudentAnswerItems;
  ListParent(this.listStudentAnswerItems, this.listChildrenItem);

  @override
  _ListParentState createState() => _ListParentState();
}

class _ListParentState extends State<ListParent> {
  ScrollController scrollController = ScrollController();
  StudentDetailBloc _bloc;
  StudentDetailScrollParentBloc _blocparent;

  List<Tab> tabView = [
    const Tab(
      text: 'Bài làm',
    ),
  ];

  @override
  void initState() {
    _bloc = context.read<StudentDetailBloc>();
    _blocparent = context.read<StudentDetailScrollParentBloc>();

    scrollController.addListener(() {
      final index = (scrollController.offset + 100) ~/
          (MediaQuery.of(context).size.width * 0.85);

      final parent = widget.listStudentAnswerItems[index];
      if (parent.isParent != 1) {
        _bloc.add(ParentScrollChangeEvent(parent.index - 1, 0));
        return;
      } else {
        _bloc.add(ParentScrollChangeEvent(
            parent.children[0].index - 1, _blocparent.state.tabIndex));
        return;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentDetailScrollParentBloc, StudentDetailState>(
        builder: (context, state) {
      return Container(
        child: Container(
          margin: const EdgeInsets.only(top: 16),
          child: DefaultTabController(
            length: tabView.length,
            child: Column(children: [
              Container(
                color: FColors.grey1,
                child: TabBar(
                  tabs: tabView,
                  indicatorColor: SkinColor.primary,
                  labelColor: SkinColor.primary,
                  labelStyle:
                      CustomFont.regular14_22.copyWith(color: FColors.grey7),
                  unselectedLabelStyle:
                      CustomFont.regular14_22.copyWith(color: FColors.grey7),
                  unselectedLabelColor: FColors.grey7,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 16),
                height: 570,
                child: TabBarView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    AnswerList(widget.listStudentAnswerItems,
                        widget.listChildrenItem, scrollController),
                  ],
                ),
              ),
            ]),
          ),
        ),
      );
    }, listener: (context, state) {
      var position =
          state.index * (MediaQuery.of(context).size.width * 0.82 + 16);
      scrollController.animateTo(position,
          duration: const Duration(seconds: 1), curve: Curves.ease);
    });
  }
}

class ListFooter extends StatefulWidget {
  final List<StudentAnswerItem> listStudentAnswerItems;
  final List<StudentAnswerItem> listChildrenItem;
  ListFooter(this.listStudentAnswerItems, this.listChildrenItem);

  @override
  _ListFooterState createState() => _ListFooterState();
}

class _ListFooterState extends State<ListFooter> {
  StudentAnswerItem answerItem;
  int index;
  ScrollController scrollController = ScrollController();
  StudentDetailBloc _bloc;
  StudentDetailScrollParentBloc _blocScrollParent;

  List<Widget> buildRow(List<StudentAnswerItem> listStudentAnswerItems,
      List<StudentAnswerItem> listChildrenItem, StudentDetailState state) {
    final lst = <Widget>[];
    for (var parentIndex = 0;
        parentIndex < listStudentAnswerItems.length;
        parentIndex++) {
      final element = listStudentAnswerItems[parentIndex];

      if (element.isParent != 1) {
        lst.add(GestureDetector(
          onTap: () {
            _blocScrollParent
                .add(ParentScrollChangeEvent(element.parentIndex - 1, 0));
          },
          child: Container(
            margin: const EdgeInsets.only(right: 8),
            child: question(
                answerItem: element,
                index: element.index,
                currentIndex: state.index,
                txtIndex: '${element.index}'),
          ),
        ));
      } else {
        final children = listChildrenItem
            .where((child) => child.parentId == element.id)
            .toList();
        for (var index = 0; index < children.length; index++) {
          final child = children[index];
          var currentIndex = 0;
          if (state is ScrollParentState) {
            currentIndex = state.index + state.tabIndex;
          }
          if (state is ScrollState) {
            currentIndex = state.index;
          }

          lst.add(GestureDetector(
            onTap: () {
              _bloc.add(ScrollChangeEvent(child.index - 1, index));
              _blocScrollParent
                  .add(ScrollChangeEvent(child.parentIndex - 1, index));
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              child: question(
                  answerItem: child,
                  index: child.index,
                  currentIndex: currentIndex,
                  txtIndex: '${child.index}'),
            ),
          ));
        }
      }
    }

    return lst;
  }

  @override
  void initState() {
    _bloc = context.read<StudentDetailBloc>();
    _blocScrollParent = context.read<StudentDetailScrollParentBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentDetailBloc, StudentDetailState>(
      builder: (context, state) {
        var a = 1;
        return Container(
          height: 50,
          color: FColors.grey1,
          padding: const EdgeInsets.fromLTRB(16, 5, 0, 5),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            controller: scrollController,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: FColors.transparent,
                        builder: (context) => TestDetail(
                            widget.listStudentAnswerItems,
                            widget.listChildrenItem,
                            scrollController,
                            _blocScrollParent));
                  },
                  child: Container(
                    height: 32,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    margin: const EdgeInsets.only(right: 6),
                    decoration: BoxDecoration(
                        color: SkinColor.primary,
                        borderRadius: BorderRadius.circular(32)),
                    child: const FText(
                      'All',
                      color: FColors.grey1,
                    ),
                  ),
                ),
                ...buildRow(widget.listStudentAnswerItems,
                    widget.listChildrenItem, state)
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        var xPosition = state.index * 32.0;

        if (xPosition < MediaQuery.of(context).size.width / 2) {
          xPosition = 0;
        }

        if (xPosition < scrollController.position.maxScrollExtent) {
          scrollController.animateTo(xPosition,
              duration: const Duration(seconds: 1), curve: Curves.ease);
        }
      },
    );
  }

  Widget question(
      {StudentAnswerItem answerItem,
      int index,
      int currentIndex,
      String txtIndex}) {
    Color color;
    Color borderColor;
    if (answerItem.answer == null || answerItem.answer == '') {
      color = FColors.grey7;
      borderColor = FColors.grey4;
    } else if (answerItem.statusAnswer == true) {
      color = FColors.green6;
      borderColor = FColors.green6;
    } else if (answerItem.answer != '' &&
        answerItem.answer != null &&
        answerItem.statusAnswer == false) {
      color = FColors.red6;
      borderColor = FColors.red6;
    }
    return FBoundingBox(
      backgroundColor:
          index != currentIndex + 1 ? FColors.transparent : FColors.grey7,
      size: FBoxSize.size32x32,
      type: FBoundingBoxType.circle,
      child: Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(16),
        ),
        child: FText(
          '$txtIndex',
          textAlign: TextAlign.center,
          style: FTextStyle.titleModules6,
          color: (answerItem.answer == null || answerItem.answer == '') &&
                  index == currentIndex + 1
              ? FColors.grey1
              : color,
        ),
      ),
    );
  }
}
