import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/AppBar.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/ComponentsBase.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/Text.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/RubricInClass/Actions/AddRubric.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/RubricInClass/Actions/ListRubricInClass.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/RubricInClass/Blocs/RubricInClassBloc.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/RubricInClass/Blocs/RubricInClassState.dart';
import 'package:khao_thi_gv/FIS.SYS/Skins/KhaoThi/SkinColor.dart';
import 'package:khao_thi_gv/FIS.SYS/Skins/Typography.dart';
import 'package:khao_thi_gv/FIS.SYS/Styles/Colors.dart';
import 'package:khao_thi_gv/FIS.SYS/Styles/Icons.dart';

class ListRubric extends StatefulWidget {
  @override
  _ListRubricState createState() => _ListRubricState();
}

class _ListRubricState extends State<ListRubric> {
  String searchValue;
  RubricInClassBloc _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = context.read<RubricInClassBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FAppBar(
        headerCenter: Container(
          alignment: Alignment.center,
          child: FText(
            'Đánh giá',
            style: FTextStyle.titleModules3,
          ),
        ),
        headerActions: [Container(width: 24)],
        headerLead: FIconButton(
          icon: FOutlinedIcons.left,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: FColors.grey1,
          size: FIconButtonSize.size48,
          color: FColors.grey9,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 12),
        color: FColors.grey3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocConsumer<RubricInClassBloc, RubricInClassState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Container(
                  color: FColors.grey1,
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FText(
                              '${state.classes.name}',
                              style: FTextStyle.titleModules6,
                              maxLines: 2,
                            ),
                            FText(
                              '${state.classes.studentCount} học sinh',
                              style: FTextStyle.subtitle2,
                            )
                          ],
                        ),
                      ),
                      FTag(
                        title: '${state.classes.rubricCount} Rubric',
                        color: state.classes.rubricCount > 0
                            ? FColors.green6
                            : FColors.orange6,
                        backgroundColor: state.classes.rubricCount > 0
                            ? FColors.green1
                            : FColors.orange1,
                        leftIcon: state.classes.rubricCount > 0
                            ? FOutlinedIcons.check
                            : FOutlinedIcons.close,
                      )
                    ],
                  ),
                );
              },
            ),
            BlocConsumer<RubricInClassBloc, RubricInClassState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state.classes.classRubrics.isNotEmpty) {
                  return AddRubrid(
                    classId: state.classes.id,
                  );
                }
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 16),
                    color: FColors.grey1,
                    child: Center(
                      child: Column(
                        children: [
                          SvgPicture.asset(
                              'lib/FIS.SYS/Assets/images/danhgia.svg'),
                          // SizedBox(height: 24),
                          FText(
                            'Hiện chưa có Rubric cho lớp học này',
                            style: FTextStyle.titleModules3,
                          ),
                          FText(
                            'Quý thầy, cô vui lòng thêm Rubric.',
                            style: FTextStyle.bodyText2,
                          ),
                          SizedBox(height: 24),
                          FButton(
                            title: 'Thêm Rubric',
                            onPressed: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                backgroundColor: FColors.transparent,
                                builder: (BuildContext context) {
                                  return AddRubricView(
                                    bloc: _bloc,
                                    classId: state.classes.id,
                                  );
                                },
                              );
                            },
                            backgroundColor: SkinColor.primary,
                            color: FColors.grey1,
                            size: FButtonSize.size48,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            ListRubricInClass(),
          ],
        ),
      ),
    );
  }
}
