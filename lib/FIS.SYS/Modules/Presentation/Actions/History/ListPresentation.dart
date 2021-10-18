import 'package:flutter/material.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Presentation/PresentationItem.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Presentation/Providers/PresentationHistoryProvider.dart';

import 'package:khao_thi_gv/FIS.SYS/Styles/Colors.dart';
import 'package:provider/provider.dart';

import '../ListPresentation.dart';
import 'AnswerSummary.dart';

class ListHistoryPresentation
    extends ListPresentation<PresentationHistoryProvider> {
  ListHistoryPresentation(PresentationItem present, bool isEnd)
      : super(present, isEnd: isEnd);

  @override
  _LListHistoryPresentation createState() => _LListHistoryPresentation();
}

class _LListHistoryPresentation
    extends ListPresentationState<PresentationHistoryProvider> {
  @override
  Future<void> startPresentation(
      BuildContext context, PresentationItem present, int index) async {
    if (isShowModal) {
      return;
    }
    isShowModal = true;

    await loadFullQuestion();
    final students =
        Provider.of<PresentationHistoryProvider>(context, listen: false)
            .students;
    if (students.isEmpty) {
      isShowModal = false;
      return;
    }

    await showModalBottomSheet(
        context: context,
        backgroundColor: FColors.transparent,
        elevation: 0,
        enableDrag: true,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        builder: (context) => AnswerSummaryHistory(
            students, index, widget.client, widget.present));

    isShowModal = false;

    return;
  }
}
