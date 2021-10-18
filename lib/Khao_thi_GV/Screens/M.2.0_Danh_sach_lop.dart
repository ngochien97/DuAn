import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/ClassRubric/Actions/ListItem.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/ClassRubric/Bloc/ClassRubricBloc.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/ClassRubric/Bloc/ClassRubricEvent.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/ClassRubric/Bloc/ClassRubricState.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/Grades/Actions/ListItem.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/Grades/Bloc/GradesBloc.dart';
import 'package:khao_thi_gv/FIS.SYS/Styles/Icons.dart';
import 'package:khao_thi_gv/locator.dart';

import '../../FIS.SYS/Components/ComponentsBase.dart';
import '../../FIS.SYS/Skins/Typography.dart';
import '../../FIS.SYS/Styles/Colors.dart';

class AppraiseScreen extends StatefulWidget {
  @override
  _AppraiseScreenState createState() => _AppraiseScreenState();
}

class _AppraiseScreenState extends State<AppraiseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: FColors.grey3,
        appBar: FAppBar(
          headerCenter: Container(
            alignment: Alignment.center,
            child: FText(
              'Đánh giá',
              style: FTextStyle.titleModules3,
            ),
          ),
          headerLead: Container(width: 82),
          bottom: Column(
            children: [
              FDivider(
                height: 1,
              ),
              Container(
                margin: EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
                child: FTextField(
                  size: FTextFieldSize.size32,
                  backgroundColor: FColors.grey3,
                  label: 'Tìm kiếm lớp',
                  leftIcon: FOutlinedIcons.search,
                  onFocus: (value) {},
                  onSubmitted: (value) {
                    locator<ClassRubricBloc>().add(SearchEvent(txt: value));
                  },
                ),
              ),
            ],
          ),
          headerActions: [
            Container(
              child: FButton(
                title: 'Chọn khối',
                color: FColors.blue6,
                backgroundColor: FColors.grey1,
                onPressed: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    backgroundColor: FColors.transparent,
                    builder: (BuildContext context) {
                      return BlocConsumer<ClassRubricBloc, ClassRubricState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            return BlocProvider(
                              create: (BuildContext context) => GradesBloc(),
                              child: GradesList(state.grades ?? []),
                            );
                          });
                    },
                  );
                },
              ),
            ),
          ],
        ),
        body: Container(
            margin: EdgeInsets.only(top: 10), child: ClassRubricList()));
  }
}
