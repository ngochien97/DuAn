import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:khao_thi_gv/F.Utils/StaticNumber.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/BottomSheet.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/Button.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/Tag.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/Text.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/ClassRubric/Bloc/ClassRubricBloc.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/ClassRubric/Bloc/ClassRubricEvent.dart';
import 'package:khao_thi_gv/FIS.SYS/Skins/Typography.dart';
// import 'package:khao_thi_gv/FIS.SYS/Components/Tag.dart';
// import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/ClassRubric/Bloc/ClassRubricBloc.dart';
// import 'package:khao_thi_gv/FIS.SYS/Modules/Assessment/ClassRubric/Bloc/ClassRubricEvent.dart';
import 'package:khao_thi_gv/FIS.SYS/Styles/Colors.dart';
import 'package:khao_thi_gv/locator.dart';

// import '../../../../../locator.dart';
import '../Bloc/GradesBloc.dart';
import '../Bloc/GradesEvent.dart';
import '../Bloc/GradesState.dart';

class GradesList extends StatefulWidget {
  List<String> gradeSelected;
  GradesList(this.gradeSelected, {Key key}) : super(key: key);

  @override
  _GradesListState createState() => _GradesListState();
}

class _GradesListState extends State<GradesList> {
  GradesBloc _bloc;
  List<String> gradeSelected;
  @override
  void initState() {
    super.initState();
    _bloc = context.read<GradesBloc>();
    _bloc.add(LoadGradeFirstEvent());
    gradeSelected = widget.gradeSelected;
  }

  @override
  Widget build(BuildContext context) {
    return FBottomSheet(
      header: FModal(
        title: FText('Chọn khối', style: FTextStyle.titleModules3),
        textAction: FButton(
          size: FButtonSize.size40,
          title: 'xong',
          color: FColors.blue6,
          backgroundColor: FColors.grey1,
          onPressed: () {
            locator<ClassRubricBloc>()
                .add(SearchEvent(grades: widget.gradeSelected));
            Navigator.of(context).pop();
          },
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
      body: BlocConsumer<GradesBloc, GradesState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is LoadingState) {
            return Container(
                color: FColors.grey1,
                height: 200,
                child: StaticNumber.baseShimmer);
          }
          return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              color: FColors.grey1,
              child: Wrap(
                children: [
                  ...List.generate(
                      state.grades.length,
                      (index) => Container(
                            margin: EdgeInsets.only(right: 8, bottom: 12),
                            width: 75,
                            child: GestureDetector(
                              onTap: () {
                                final grade = state.grades[index];
                                if (gradeSelected.contains(grade.key)) {
                                  gradeSelected.remove(grade.key);
                                } else {
                                  gradeSelected.add(grade.key);
                                }

                                setState(() {});
                              },
                              child: FTag(
                                title: state.grades[index].value,
                                color: gradeSelected
                                        .contains(state.grades[index].key)
                                    ? FColors.blue6
                                    : FColors.grey7,
                                size: FTagSize.medium,
                                onPressed: () {},
                              ),
                            ),
                          ))
                ],
              ));
        },
      ),
    );
  }

  void buildItem() {}
}
