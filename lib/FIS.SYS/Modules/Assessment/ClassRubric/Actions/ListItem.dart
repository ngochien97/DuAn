import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:khao_thi_gv/F.Utils/StaticNumber.dart';
import 'package:khao_thi_gv/FIS.SYS/Styles/Colors.dart';

import '../Bloc/ClassRubricBloc.dart';
import '../Bloc/ClassRubricEvent.dart';
import '../Bloc/ClassRubricState.dart';
import '../Card/ClassRubricCard.dart';

class ClassRubricList extends StatefulWidget {
  ClassRubricList({Key key}) : super(key: key);

  @override
  _ClassRubricListState createState() => _ClassRubricListState();
}

class _ClassRubricListState extends State<ClassRubricList> {
  ClassRubricBloc _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = context.read<ClassRubricBloc>();
    _bloc.add(LoadFirstEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClassRubricBloc, ClassRubricState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is LoadingState) {
          return StaticNumber.baseShimmer;
        }
        return RefreshIndicator(
          onRefresh: () async {
            _bloc.add(RefreshEvent());
          },
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              color: FColors.grey1,
              child: Column(
                children: List.generate(
                    state.classShow.length,
                    (index) => ClassRubricCard(
                          state.classShow[index],
                          key: Key(
                              'ClassRubricCard${state.classShow[index].id}'),
                        )),
              ),
            ),
          ),
        );
      },
    );
  }

  void buildItem() {}
}
