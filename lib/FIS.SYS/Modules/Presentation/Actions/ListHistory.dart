import 'package:flutter/material.dart';
import 'package:khao_thi_gv/F.Utils/Utils.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Presentation/Actions/ListTopic.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Presentation/Providers/PresentationHistoryProvider.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Students/StudentDetailDA.dart';
import 'package:provider/provider.dart';

import '../../../../F.Utils/SrceenExtensions.dart';
import '../../../Components/ComponentsBase.dart';
import '../../../Skins/Typography.dart';
import '../../../Styles/StyleBase.dart';
import '../Providers/PresentationHistoryProvider.dart';
import 'History/ListPresentation.dart';

class ListHistory extends StatefulWidget {
  final int classId;
  ListHistory(this.classId);
  @override
  _ListHistoryState createState() => _ListHistoryState();
}

class _ListHistoryState extends State<ListHistory> {
  bool isLoadmore = false;
  bool notify = false;
  final ScrollController _controller = ScrollController();
  PresentationHistoryProvider provider;
  bool isLoading = true;
  StudentDetailDA studentDetailDA = StudentDetailDA();

  Future loadHistoryData() async {
    provider.init(widget.classId);
    final historyData = await provider.loadData();
    if (historyData.presents.isNotEmpty) {
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
        notify = true;
      });
    }
  }

  void getStudent() {
    studentDetailDA.getStudentInClassFromCache(widget.classId).then((data) {
      if (data.code == 200) {
        Provider.of<PresentationHistoryProvider>(context, listen: false)
            .students = data.students;
      }
    }).catchError(Utils.error);
  }

  Future scrollToLoadMore() async {
    if (isLoadmore) {
      return;
    }
    if (_controller.position.extentAfter < 100) {
      setState(() {
        isLoadmore = true;
      });

      await Provider.of<PresentationHistoryProvider>(context, listen: false)
          .loadMoreData();
      setState(() {
        isLoadmore = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    provider = Provider.of<PresentationHistoryProvider>(context, listen: false);
    loadHistoryData();
    getStudent();

    _controller.addListener(scrollToLoadMore);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? TopicLoading()
        : notify
            ? Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.6),
                ),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [FEffect.elevation1],
                      color: FColors.grey1,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const FText(
                      'Chưa có dữ liệu',
                      style: FTextStyle.titleModules4,
                    ),
                  ),
                ),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  await loadHistoryData();
                },
                child: Consumer<PresentationHistoryProvider>(
                  builder: (context, presentProvider, child) => Stack(
                    alignment: Alignment.center,
                    children: [
                      ListView.builder(
                          controller: _controller,
                          itemCount: presentProvider.presents.length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final present = presentProvider.presents[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(16.h),
                                  width: 382.w,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FText(
                                          present.name,
                                          style: FTextStyle.titleModules3,
                                        ),
                                        FText(
                                          '${present.statusName}',
                                          style: FTextStyle.subtitle2,
                                          color: FColors.green6,
                                        ),
                                        FSpacer.space8px,
                                        LinearProgressIndicator(
                                          value: 1,
                                          backgroundColor: FColors.grey4,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  FColors.green6),
                                        )
                                      ]),
                                ),
                                present.items == null
                                    ? Container()
                                    : ListHistoryPresentation(present, true),
                                FDivider(
                                  space: 24,
                                ),
                              ],
                            );
                          }),
                      if (isLoadmore)
                        Positioned(
                          bottom: 4.0,
                          width: 30,
                          height: 30.0,
                          child: CircularProgressIndicator(
                            strokeWidth: 3.0,
                          ),
                        )
                    ],
                  ),
                ),
              );
  }
}
