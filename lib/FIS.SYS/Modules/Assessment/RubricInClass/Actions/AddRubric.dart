import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khao_thi_gv/F.Utils/StaticNumber.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/BottomSheet.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/Button.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/Text.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/TextField.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/ClassRubric/Bloc/ClassRubricBloc.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/ClassRubric/Bloc/ClassRubricEvent.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/DA/ClassRubricDA.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/Models/ClassRubricItem.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/Models/ClassRubricsItem.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/RubricInClass/Blocs/RubricInClassBloc.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/RubricInClass/Blocs/RubricInClassEvent.dart';
import 'package:khao_thi_gv/FIS.SYS/Skins/KhaoThi/SkinColor.dart';
import 'package:khao_thi_gv/FIS.SYS/Skins/Typography.dart';
import 'package:khao_thi_gv/FIS.SYS/Styles/Colors.dart';
import 'package:khao_thi_gv/FIS.SYS/Styles/Icons.dart';
import 'package:khao_thi_gv/F.Utils/Utils.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khao_thi_gv/locator.dart';

class AddRubrid extends StatefulWidget {
  final int classId;
  AddRubrid({Key key, this.classId}) : super(key: key);

  @override
  _AddRubridState createState() => _AddRubridState();
}

class _AddRubridState extends State<AddRubrid> {
  RubricInClassBloc _bloc;
  @override
  void initState() {
    super.initState();

    _bloc = context.read<RubricInClassBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 0, 16),
      child: Row(
        children: [
          Expanded(
            child: FText(
              'Danh sách Rubric',
              style: FTextStyle.bodyText1,
            ),
          ),
          FButton(
            title: 'Thêm Rubric',
            backgroundColor: FColors.grey3,
            color: FColors.blue6,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                backgroundColor: FColors.transparent,
                builder: (BuildContext context) {
                  return AddRubricView(
                    bloc: _bloc,
                    classId: widget.classId,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class AddRubricView extends StatefulWidget {
  final RubricInClassBloc bloc;
  final int classId;
  AddRubricView({Key key, this.bloc, this.classId}) : super(key: key);

  @override
  _AddRubricViewState createState() => _AddRubricViewState();
}

class _AddRubricViewState extends State<AddRubricView> {
  ClassRubricDA da = ClassRubricDA();
  List<ClassRubricsItem> rubrics = [];
  bool isLoading = false;
  Future<void> searchRubric(String txt) async {
    setState(() {
      isLoading = true;
    });
    try {
      final data = await da.searchRubric(txt);
      if (data.code == 200) {
        rubrics = data.rubrics;
        isLoading = false;
        setState(() {});
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> selected(ClassRubricsItem rubric) async {
    final data = await da.addRubric(widget.classId, rubric.id);
    if (data.code == 200) {
      locator<ClassRubricBloc>().add(AppendRubricEvent(rubric, widget.classId));
      widget.bloc.add(AppendEvent(ClassRubrics(
          id: data.id,
          rubricCode: rubric.rubricCode,
          rubricName: rubric.rubricName)));
      Navigator.of(context).pop();
    } else {
      Utils.showMessage(data.message ?? '', SkinColor.error, context);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
            margin: EdgeInsets.only(top: 24.0),
            child: FBottomSheet(
              header: FModal(
                title: FText('Thêm Rubric', style: FTextStyle.titleModules3),
                textAction: FButton(
                  size: FButtonSize.size40,
                  title: 'Xong',
                  color: FColors.blue6,
                  backgroundColor: FColors.grey1,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                bottom: Container(
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: FTextField(
                      label: 'Tìm theo tên/mã Rubric',
                      size: FTextFieldSize.size40,
                      leftIcon: FOutlinedIcons.search,
                      onChanged: (value) {},
                      onFocus: (value) {},
                      onSubmitted: (value) async {
                        await searchRubric(value);
                      }),
                ),
              ),
              body: Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  color: FColors.grey3,
                  child: isLoading
                      ? StaticNumber.baseShimmer
                      : SingleChildScrollView(
                          child: Column(
                              children: List.generate(
                                  rubrics.length,
                                  (index) => Container(
                                        margin: EdgeInsets.only(top: 16),
                                        padding: EdgeInsets.all(16),
                                        color: FColors.grey1,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  selected(rubrics[index]);
                                                },
                                                child: Container(
                                                  color: Colors.transparent,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      FText(
                                                        '${rubrics[index].rubricName}',
                                                        style: FTextStyle
                                                            .buttonText2,
                                                        maxLines: 2,
                                                      ),
                                                      FText(
                                                        'Mã: ${rubrics[index].rubricCode}',
                                                        style: FTextStyle
                                                            .subtitle2,
                                                        color: FColors.blue6,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))),
                        ),
                ),
              ),
            )));
  }
}
