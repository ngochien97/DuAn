import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:khao_thi_gv/FIS.SYS/Components/Button.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/IconButton.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/Text.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/ClassRubric/Bloc/ClassRubricBloc.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/ClassRubric/Bloc/ClassRubricEvent.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/DA/ClassRubricDA.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/Models/ClassRubricItem.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/RubricInClass/Blocs/RubricInClassBloc.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/RubricInClass/Blocs/RubricInClassEvent.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/RubricInClass/Blocs/RubricInClassState.dart';
import 'package:khao_thi_gv/FIS.SYS/Skins/Typography.dart';
import 'package:khao_thi_gv/FIS.SYS/Styles/Colors.dart';
import 'package:khao_thi_gv/FIS.SYS/Styles/Icons.dart';
import 'package:khao_thi_gv/Khao_thi_GV/Screens/M.2.2_Danh_sach_hoc_sinh.dart';
import 'package:khao_thi_gv/locator.dart';

class ListRubricInClass extends StatefulWidget {
  ListRubricInClass({Key key}) : super(key: key);

  @override
  _ListRubricInClassState createState() => _ListRubricInClassState();
}

class _ListRubricInClassState extends State<ListRubricInClass> {
  ClassRubricDA da = ClassRubricDA();
  bool isLoading = false;
  RubricInClassBloc _bloc;
  Future<void> removeRubric(
      int classId, ClassRubrics item, StateSetter mystate) async {
    if (isLoading) {
      return;
    }
    try {
      mystate(() {
        isLoading = true;
      });
      final data = await da.removeRubric(item.id);
      if (data.code == 200) {
        locator<ClassRubricBloc>().add(RemoveRubricEvent(classId, item.id));
        _bloc.add(RemoveEvent(item));

        Navigator.of(context).pop();
      }
      mystate(() {
        isLoading = false;
      });
    } catch (e) {
      mystate(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _bloc = context.read<RubricInClassBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RubricInClassBloc, RubricInClassState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.classes.classRubrics.isEmpty) {
          return Container();
        }
        return Expanded(
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (var item in state.classes.classRubrics)
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      padding: EdgeInsets.all(16),
                      color: FColors.grey1,
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ListStudent()));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FText(
                                    item.rubricName,
                                    style: FTextStyle.buttonText2,
                                    maxLines: 2,
                                  ),
                                  FText(
                                    'Mã: ${item.rubricCode}',
                                    style: FTextStyle.subtitle2,
                                    color: FColors.blue6,
                                  )
                                ],
                              ),
                            ),
                          ),
                          FIconButton(
                            icon: FFilledIcons.edit,
                            color: FColors.blue6,
                            backgroundColor: FColors.geek_blue1,
                            onPressed: () {},
                          ),
                          FIconButton(
                            icon: FFilledIcons.delete,
                            color: FColors.red6,
                            backgroundColor: FColors.red1,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => StatefulBuilder(
                                  builder: (BuildContext context, mysetState) {
                                    return AlertDialog(
                                      scrollable: true,
                                      title: FText(
                                        'Thầy cô có muốn xóa Rubric này của lớp',
                                        style: FTextStyle.titleModules3,
                                      ),
                                      actions: [
                                        FButton(
                                          title: 'Hủy',
                                          backgroundColor: FColors.grey1,
                                          color: FColors.grey7,
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        FButton(
                                          title: 'Xóa Rubric',
                                          isLoading: isLoading,
                                          backgroundColor: FColors.blue6,
                                          color: FColors.grey1,
                                          onPressed: () {
                                            removeRubric(state.classes.id, item,
                                                mysetState);
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
