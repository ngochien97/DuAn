import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:khao_thi_gv/F.Utils/Utils.dart';
import 'package:khao_thi_gv/FIS.SYS/Core/CacheService.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Notifications/Models/HistoryNotificationItem.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TakerGroups/Provider/TakerGroupCloseProvider.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TakerGroups/Provider/TakerGroupDeletedProvider.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TakerGroups/bloc/student_detail/takergroup/NotificationBloc.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TakerGroups/bloc/student_detail/takergroup/NotificationEvent.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TakerGroups/bloc/student_detail/takergroup/NotificationState.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../F.Utils/Convert.dart';
import '../../../../Khao_thi_GV/RouteNames.dart';
import '../../../../locator.dart';
import '../../../Components/ComponentsBase.dart';
import '../../../Core/routes.dart';
import '../../../Skins/Icon.dart';
import '../../../Skins/KhaoThi/SkinColor.dart';
import '../../../Skins/Typography.dart';
import '../../../Styles/StyleBase.dart';
import '../DA/TakerGroupDA.dart';
import '../Provider/TakerGroupProvider.dart';
import '../TakerGroup.dart';
import '../TakerGroupStatus.dart';
import 'EditView.dart';
import 'Proctor.dart';

class TabView<T extends TakerGroupProvider> extends StatefulWidget {
  @override
  _TabViewState createState() => _TabViewState<T>();
}

class _TabViewState<T extends TakerGroupProvider> extends State<TabView<T>>
    with SingleTickerProviderStateMixin {
  DateTime fromTime = DateTime.now();
  DateTime dueTime = DateTime.now();
  DateTime toTime = DateTime.now();
  int timeLimit = 0;
  int groupEditId = 0;
  final ScrollController _controller = ScrollController();
  TextEditingController dateCtl = TextEditingController();
  bool isLoadMore = false;
  bool isLoading = false;
  bool isFirstLoading = true;

  final DateFormat formatter = DateFormat('dd/MM/yyyy, HH:mm');
  TakerGroupDA takerGroupDA = TakerGroupDA.instance;

  Future<void> scrollToLoadMore() async {
    if (_controller.position.extentAfter < 100) {
      if (isLoadMore) {
        return;
      }
      setState(() {
        isLoadMore = true;
      });

      await Provider.of<T>(context, listen: false).loadMoreData();
      setState(() {
        isLoadMore = false;
      });
    }
  }

  Color getColorStatus(int status) {
    var colorStatus = SkinColor.primary;
    switch (status) {
      case 1:
        colorStatus = FColors.magenta6;
        break;
      case 11:
      case 13:
        colorStatus = SkinColor.primary;
        break;
      case 15:
        colorStatus = FColors.red6;
        break;
      case 17:
        colorStatus = FColors.orange6;
        break;
      case 19:
      case 20:
      case -1:
        colorStatus = FColors.grey6;
        break;
      default:
    }
    return colorStatus;
  }

  void playGroup(TakerGroup group) {
    showDialog(
        context: context,
        builder: (_) => StatefulBuilder(
            builder: (context, setState) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0))),
                    content: Container(
                      child: FText(
                        'Thầy, cô có muốn bắt đầu kíp thi?',
                        style: FTextStyle.buttonText1,
                        color: FColors.grey9,
                      ),
                    ),
                    actions: <Widget>[
                      FButton(
                        title: 'Hủy',
                        backgroundColor: FColors.transparent,
                        color: FColors.grey7,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      FButton(
                          title: 'Bắt đầu kíp thi',
                          // isLoading: isLoading,
                          onPressed: () async {
                            // if (isLoading) {
                            //   return;
                            // }
                            // setState(() {
                            //   isLoading = true;
                            // });
                            final data =
                                await takerGroupDA.takerGroupStart(group);
                            // setState(() {
                            //   isLoading = false;
                            // });

                            if (data.code == 200) {
                              final provider =
                                  Provider.of<T>(context, listen: false);
                              await provider.refreshData(data.takerGroup);
                              await provider.loadData();
                              Navigator.of(context).pop();
                            }
                            showFSnackBar(
                                context,
                                FSnackBar(
                                  message: FText(
                                    '${data.message}',
                                    color: FColors.grey1,
                                  ),
                                  borderRadius: 8.0,
                                  position: FlushbarPosition.TOP,
                                  backgroundColor: data.code == 200
                                      ? SkinColor.success
                                      : SkinColor.error,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                ));
                          }),
                    ])));
  }

  void pauseGroup(TakerGroup group) {
    showDialog(
        context: context,
        builder: (_) => StatefulBuilder(
            builder: (context, setState) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0))),
                    content: Container(
                      child: FText(
                        'Thầy, cô có muốn tạm dừng kíp thi?',
                        style: FTextStyle.buttonText1,
                        color: FColors.grey9,
                      ),
                    ),
                    actions: <Widget>[
                      FButton(
                        title: 'Hủy',
                        backgroundColor: FColors.transparent,
                        color: FColors.grey7,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      FButton(
                          title: 'Tạm dừng kíp thi',
                          isLoading: isLoading,
                          onPressed: () async {
                            if (isLoading) {
                              return;
                            }
                            setState(() {
                              isLoading = true;
                            });
                            final data =
                                await takerGroupDA.takerGroupPause(group);
                            setState(() {
                              isLoading = false;
                            });

                            if (data.code == 200) {
                              final provider =
                                  Provider.of<T>(context, listen: false);
                              await provider.refreshData(data.takerGroup);
                              Navigator.of(context).pop();
                            }
                            showFSnackBar(
                                context,
                                FSnackBar(
                                  message: FText(
                                    '${data.message}',
                                    color: FColors.grey1,
                                  ),
                                  borderRadius: 8.0,
                                  position: FlushbarPosition.TOP,
                                  backgroundColor: data.code == 200
                                      ? SkinColor.success
                                      : SkinColor.error,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                ));
                          }),
                    ])));
  }

  void lockGroup(TakerGroup group) {
    showDialog(
        context: context,
        builder: (_) => StatefulBuilder(
            builder: (context, setState) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0))),
                    content: Container(
                      child: FText(
                        'Thầy, cô có muốn khóa rút đề kíp thi?',
                        style: FTextStyle.buttonText1,
                        color: FColors.grey9,
                      ),
                    ),
                    actions: <Widget>[
                      FButton(
                        title: 'Hủy',
                        backgroundColor: FColors.transparent,
                        color: FColors.grey7,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      FButton(
                          title: 'Khóa rút đề',
                          isLoading: isLoading,
                          onPressed: () async {
                            if (isLoading) {
                              return;
                            }
                            setState(() {
                              isLoading = true;
                            });
                            final data =
                                await takerGroupDA.takerGroupLock(group);
                            setState(() {
                              isLoading = false;
                            });

                            if (data.code == 200) {
                              final provider =
                                  Provider.of<T>(context, listen: false);
                              await provider.refreshData(data.takerGroup);
                              await provider.loadData();
                              Navigator.of(context).pop();
                            }
                            showFSnackBar(
                                context,
                                FSnackBar(
                                  message: FText(
                                    '${data.message}',
                                    color: FColors.grey1,
                                  ),
                                  borderRadius: 8.0,
                                  position: FlushbarPosition.TOP,
                                  backgroundColor: data.code == 200
                                      ? SkinColor.success
                                      : SkinColor.error,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                ));
                          }),
                    ])));
  }

  void stopGroup(TakerGroup group) {
    showDialog(
        context: context,
        builder: (_) => StatefulBuilder(
            builder: (context, setState) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0))),
                    content: Container(
                      child: FText(
                        'Thầy, cô có muốn kết thúc kíp thi?',
                        style: FTextStyle.buttonText1,
                        color: FColors.grey9,
                      ),
                    ),
                    actions: <Widget>[
                      FButton(
                        title: 'Hủy',
                        backgroundColor: FColors.transparent,
                        color: FColors.grey7,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      FButton(
                          title: 'Kết thúc kíp thi',
                          isLoading: isLoading,
                          onPressed: () async {
                            if (isLoading) {
                              return;
                            }
                            setState(() {
                              isLoading = true;
                            });
                            final data =
                                await takerGroupDA.takerGroupStop(group);
                            setState(() {
                              isLoading = false;
                            });

                            if (data.code == 200) {
                              final provider =
                                  Provider.of<T>(context, listen: false);
                              await provider.refreshData(data.takerGroup);
                              await provider.loadData();
                              Navigator.of(context).pop();
                            }
                            showFSnackBar(
                                context,
                                FSnackBar(
                                  message: FText(
                                    '${data.message}',
                                    color: FColors.grey1,
                                  ),
                                  borderRadius: 8.0,
                                  position: FlushbarPosition.TOP,
                                  backgroundColor: data.code == 200
                                      ? SkinColor.success
                                      : SkinColor.error,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                ));
                          }),
                    ])));
  }

  void deleteGroup(TakerGroup group) {
    if (!(group.status == TakerGroupStatusBase.moitao ||
        group.status == TakerGroupStatusBase.daDongKip)) {
      return;
    }
    final contextParent = context;
    showDialog(
        context: context,
        builder: (_) => StatefulBuilder(
            builder: (context, setState) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0))),
                    content: Container(
                      child: FText(
                        'Thầy, cô có muốn xóa kíp thi?',
                        style: FTextStyle.buttonText1,
                        color: FColors.grey9,
                      ),
                    ),
                    actions: <Widget>[
                      FButton(
                        title: 'Hủy',
                        backgroundColor: FColors.transparent,
                        color: FColors.grey7,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      FButton(
                          title: 'Xoá kíp thi',
                          isLoading: isLoading,
                          onPressed: () async {
                            if (isLoading) {
                              return;
                            }
                            setState(() {
                              isLoading = true;
                            });
                            final data =
                                await takerGroupDA.takerGroupDelete(group.id);
                            setState(() {
                              isLoading = false;
                            });

                            if (data.code == 200) {
                              final provider =
                                  Provider.of<T>(context, listen: false);
                              await provider.removeGroup(group);
                              await provider.loadData();
                              Navigator.of(context).pop();
                              Navigator.of(contextParent).pop();
                            }
                            showFSnackBar(
                                context,
                                FSnackBar(
                                  message: FText(
                                    '${data.message}',
                                    color: FColors.grey1,
                                  ),
                                  borderRadius: 8.0,
                                  position: FlushbarPosition.TOP,
                                  backgroundColor: data.code == 200
                                      ? SkinColor.success
                                      : SkinColor.error,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                ));
                          }),
                    ])));
  }

  void restoreGroup(TakerGroup group) {
    if (group.status != TakerGroupStatusBase.daXoa) {
      return;
    }
    final contextParent = context;
    showDialog(
        context: context,
        builder: (_) => StatefulBuilder(
            builder: (context, setState) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0))),
                    content: Container(
                      child: FText(
                        'Thầy, cô có muốn khôi phục kíp thi?',
                        style: FTextStyle.buttonText1,
                        color: FColors.grey9,
                      ),
                    ),
                    actions: <Widget>[
                      FButton(
                        title: 'Hủy',
                        backgroundColor: FColors.transparent,
                        color: FColors.grey7,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      FButton(
                          title: 'Khôi phục kíp thi',
                          isLoading: isLoading,
                          onPressed: () async {
                            if (isLoading) {
                              return;
                            }
                            setState(() {
                              isLoading = true;
                            });
                            final data =
                                await takerGroupDA.takerGroupRestore(group.id);
                            setState(() {
                              isLoading = false;
                            });

                            if (data.code == 200) {
                              final provider =
                                  Provider.of<T>(context, listen: false);
                              await provider.removeGroup(group);
                              await provider.loadData();
                              Navigator.of(context).pop();
                              Navigator.of(contextParent).pop();
                            }
                            showFSnackBar(
                                context,
                                FSnackBar(
                                  message: FText(
                                    '${data.message}',
                                    color: FColors.grey1,
                                  ),
                                  borderRadius: 8.0,
                                  position: FlushbarPosition.TOP,
                                  backgroundColor: data.code == 200
                                      ? SkinColor.success
                                      : SkinColor.error,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                ));
                          }),
                    ])));
  }

  void showmore(TakerGroup group) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        elevation: 0,
        isDismissible: true,
        enableDrag: true,
        backgroundColor: FColors.transparent,
        builder: (context) => StatefulBuilder(
            builder: (context, setState) => Container(
                  child: FBottomSheet(
                    header: FModal(
                      title: FText('Chọn tác vụ'),
                      textAction: FButton(
                        title: 'Done',
                        backgroundColor: FColors.transparent,
                        color: SkinColor.primary,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    body: Container(
                      padding: EdgeInsets.all(16),
                      color: FColors.grey1,
                      child: Column(
                        children: [
                          FListTitle(
                              avatar: FBoundingBox(
                                backgroundColor: FColors.transparent,
                                size: FBoxSize.size32x32,
                                child: FIcon(
                                  icon: FFilledIcons.setting,
                                  color: [
                                    (group.status ==
                                                TakerGroupStatusBase.moitao ||
                                            group.status ==
                                                TakerGroupStatusBase.tamDung)
                                        ? SkinColor.primary
                                        : FColors.grey6
                                  ],
                                ),
                              ),
                              title: FText('Sửa kíp thi'),
                              backgroundColor: FColors.grey3,
                              onTap: () {
                                if (!(group.status ==
                                        TakerGroupStatusBase.moitao ||
                                    group.status ==
                                        TakerGroupStatusBase.tamDung)) {
                                  return;
                                }
                                groupEditId = group.id;
                                fromTime = group.fromTime;
                                dueTime = group.dueTime;
                                toTime = group.toTime;
                                timeLimit = group.timeLimit;
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  elevation: 0,
                                  isDismissible: true,
                                  enableDrag: true,
                                  backgroundColor: FColors.transparent,
                                  builder: (context) => EditTaker(
                                    group,
                                    callBack: (data) {
                                      Provider.of<T>(context, listen: false)
                                          .refreshData(data);

                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                );
                              }),
                          FSpacer.space8px,
                          FListTitle(
                            avatar: FBoundingBox(
                              backgroundColor: FColors.transparent,
                              size: FBoxSize.size32x32,
                              child: FIcon(
                                icon: FOutlinedIcons.qrcode,
                                color: [
                                  group.statusProctor &&
                                          !(group.status ==
                                              TakerGroupStatusBase.daXoa)
                                      ? FColors.green6
                                      : FColors.grey6
                                ],
                              ),
                            ),
                            title: FText('Mã giám thị'),
                            backgroundColor: FColors.grey3,
                            onTap: () {
                              if (!group.statusProctor ||
                                  group.status == TakerGroupStatusBase.daXoa) {
                                return;
                              }
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  elevation: 0,
                                  isDismissible: true,
                                  enableDrag: true,
                                  backgroundColor: FColors.transparent,
                                  builder: (context) => StatefulBuilder(
                                      builder: (context, setState) => Proctor(
                                          group.codeProctor1,
                                          group.codeProctor2)));
                            },
                          ),
                          FSpacer.space8px,
                          !(group.status == TakerGroupStatusBase.daXoa)
                              ? FListTitle(
                                  avatar: FBoundingBox(
                                    backgroundColor: FColors.transparent,
                                    size: FBoxSize.size32x32,
                                    child: FIcon(
                                      icon: FFilledIcons.delete,
                                      color: [
                                        group.status ==
                                                    TakerGroupStatusBase
                                                        .moitao ||
                                                group.status ==
                                                    TakerGroupStatusBase
                                                        .daDongKip
                                            ? FColors.red6
                                            : FColors.grey7
                                      ],
                                    ),
                                  ),
                                  title: FText(
                                    'Xóa kíp thi',
                                  ),
                                  backgroundColor: FColors.grey3,
                                  onTap: () {
                                    deleteGroup(group);
                                  },
                                )
                              : FListTitle(
                                  avatar: FBoundingBox(
                                    backgroundColor: FColors.transparent,
                                    size: FBoxSize.size32x32,
                                    child: FIcon(
                                      icon: FOutlinedIcons.reload,
                                      color: [FColors.cyan6],
                                    ),
                                  ),
                                  title: FText('Khôi phục kíp thi'),
                                  backgroundColor: FColors.grey3,
                                  onTap: () {
                                    restoreGroup(group);
                                  },
                                )
                        ],
                      ),
                    ),
                  ),
                )));
  }

  static Type typeOf<T>() => T;
  @override
  void initState() {
    super.initState();
    final takerGroupProvider = Provider.of<T>(context, listen: false);
    takerGroupProvider.loadData().then((value) {
      setState(() {
        isFirstLoading = false;
      });
    });
    _controller.addListener(scrollToLoadMore);
  }

  @override
  void didUpdateWidget(covariant TabView<T> oldWidget) {
    Provider.of<T>(context, listen: false).loadData();
    super.didUpdateWidget(oldWidget);
  }

  Future<void> _mapListenerSnackbarState(
      BuildContext context, NotificationState state) async {
    if (state is TakerGroupState) {
      if (typeOf<T>() == typeOf<TakerGroupProvider>() &&
          CoreRoutes.instance.curentRoutes != RouteNames.TEST_TAKER) {
        return;
      }
      if (typeOf<T>() == typeOf<TakerGroupCloseProvider>() &&
          CoreRoutes.instance.curentRoutes != RouteNames.TEST_TAKER_CLOSE) {
        return;
      }
      if (typeOf<T>() == typeOf<TakerGroupDeletedProvider>() &&
          CoreRoutes.instance.curentRoutes != RouteNames.TEST_TAKER_DELETE) {
        return;
      }

      final takerGroupProvider = Provider.of<T>(context, listen: false);
      final lst = takerGroupProvider.groups;
      final temp = lst.firstWhere(
          (element) => element.id == state.takerGroup.id,
          orElse: () => null);

      if (temp != null) {
        await takerGroupProvider.refreshData(state.takerGroup);
      } else {
        var jsonData = json.encode(state.takerGroup);
        var data = HistoryNotificationItem(
            '${state.takerGroup.name}', state.type, state.message,
            objectData: jsonData);
        await CacheService.add<HistoryNotificationItem>(data.id, data);
        locator<NotificationBloc>().add(GetHistoryNotificationsEvent());
        Utils.console('history');
      }
    }
  }

  @override
  Widget build(BuildContext context) => MultiBlocListener(
        listeners: [
          BlocListener<NotificationBloc, NotificationState>(
              listener: _mapListenerSnackbarState),
        ],
        child: Consumer<T>(
          builder: (context, groupProvider, _) => RefreshIndicator(
            onRefresh: () async {
              await Provider.of<T>(context, listen: false).loadData();
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: isFirstLoading
                  ? TabViewLoading()
                  : groupProvider.groups.isEmpty
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
                      : Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                key: PageStorageKey('${T.toString()}'),
                                controller: _controller,
                                physics: const BouncingScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics()),
                                itemCount: groupProvider.groups.length,
                                itemBuilder: (context, index) {
                                  Utils.console(groupProvider.groups[index].id);
                                  final group = groupProvider.groups[index];
                                  final statusColor =
                                      getColorStatus(group.status);
                                  if (group.status == 11) {
                                    Provider.of<T>(context, listen: false)
                                        .loadData();
                                  }
                                  final mapStatus =
                                      takerGroupDA.showAction(group.status);
                                  return GestureDetector(
                                    onTap: () {
                                      CoreRoutes.instance.navigateTo(
                                          RouteNames.TAKERGROUPDETAIL,
                                          arguments: group);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 16),
                                      color: FColors.transparent,
                                      child: FCard(
                                        size: FBoxSize.auto_rectangle,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 12),
                                        content: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 12),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Flexible(
                                                    child: Container(
                                                      child: FText(
                                                        '${group.name}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: FTextStyle
                                                            .titleModules5,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 8),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          alignment: Alignment
                                                              .topCenter,
                                                          child: FText(
                                                            takerGroupStatus[group
                                                                    .statusDisplay] ??
                                                                '',
                                                            color: statusColor,
                                                          ),
                                                        ),
                                                        FSpacer
                                                            .hozirontalSpace4px,
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 5),
                                                          child: FBoundingBox(
                                                            backgroundColor:
                                                                statusColor,
                                                            size: FBoxSize
                                                                .size8x8,
                                                            type:
                                                                FBoundingBoxType
                                                                    .circle,
                                                            child: Container(),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            FDivider(),
                                            FSpacer.space4px,
                                            FText(
                                                'Giờ mở kíp: ${group.getStringTimeOpen}',
                                                style: FTextStyle.subtitle2),
                                            FSpacer.space4px,
                                            FText(
                                              'Giờ đóng kíp: ${group.toTime.format("dd/MM/yyyy HH:mm")}',
                                              style: FTextStyle.subtitle2,
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 12),
                                              child: Row(children: [
                                                FTag(
                                                  title: group.controlMode
                                                      ? 'Tự động'
                                                      : 'Thủ công',
                                                  leftIcon:
                                                      FFilledIcons.clock_circle,
                                                  backgroundColor:
                                                      SkinColor.primary,
                                                  color: FColors.grey1,
                                                ),
                                                FSpacer.hozirontalSpace4px,
                                                FTooltip(
                                                  message: 'Tổng số thi sinh',
                                                  backgroundColor:
                                                      SkinColor.primary,
                                                  child: FTag(
                                                    title:
                                                        '${group.takerCount}',
                                                    leftIcon: FFilledIcons
                                                        .user_multiple,
                                                    color: SkinColor.primary,
                                                    backgroundColor:
                                                        FColors.geek_blue1,
                                                  ),
                                                ),
                                                FSpacer.hozirontalSpace4px,
                                                FTooltip(
                                                  message: 'Thí sinh đã thi',
                                                  backgroundColor:
                                                      FColors.green6,
                                                  child: FTag(
                                                    title:
                                                        '${group.takerSubmitCount}',
                                                    leftIcon:
                                                        FFilledIcons.user_check,
                                                    color: FColors.green6,
                                                    backgroundColor:
                                                        FColors.cyan1,
                                                  ),
                                                ),
                                                FSpacer.hozirontalSpace4px,
                                                FTooltip(
                                                  message: 'Thí sinh chưa thi',
                                                  backgroundColor:
                                                      FColors.orange6,
                                                  child: FTag(
                                                    title:
                                                        '${(group.takerCount ?? 0) - (group.takerSubmitCount ?? 0)}',
                                                    leftIcon:
                                                        FFilledIcons.user_time,
                                                    color: FColors.orange6,
                                                    backgroundColor:
                                                        FColors.gold1,
                                                  ),
                                                ),
                                              ]),
                                            ),
                                            FDivider(),
                                            Container(
                                              margin: EdgeInsets.only(top: 12),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  FIcon(
                                                    icon: FFilledIcons
                                                        .play_circle,
                                                    color: [
                                                      mapStatus['Play'] !=
                                                                  null &&
                                                              mapStatus['Play']
                                                          ? FColors.grey8
                                                          : FColors.grey6
                                                    ],
                                                    onPressed: () {
                                                      if (mapStatus['Play'] ==
                                                              null ||
                                                          !mapStatus['Play']) {
                                                        return;
                                                      }
                                                      playGroup(group);
                                                    },
                                                  ),
                                                  FIcon(
                                                    icon: FFilledIcons
                                                        .pause_circle,
                                                    color: [
                                                      mapStatus['Pause'] !=
                                                                  null &&
                                                              mapStatus['Pause']
                                                          ? FColors.grey8
                                                          : FColors.grey6
                                                    ],
                                                    onPressed: () {
                                                      if (mapStatus['Pause'] ==
                                                              null ||
                                                          !mapStatus['Pause']) {
                                                        return;
                                                      }
                                                      pauseGroup(group);
                                                    },
                                                  ),
                                                  FIcon(
                                                    icon: FFilledIcons.lock,
                                                    color: [
                                                      mapStatus['Lock'] !=
                                                                  null &&
                                                              mapStatus['Lock']
                                                          ? FColors.grey8
                                                          : FColors.grey6
                                                    ],
                                                    onPressed: () {
                                                      if (mapStatus['Lock'] ==
                                                              null ||
                                                          !mapStatus['Lock']) {
                                                        return;
                                                      }

                                                      lockGroup(group);
                                                    },
                                                  ),
                                                  FIcon(
                                                    icon: FFilledIcons
                                                        .engine_start,
                                                    color: [
                                                      mapStatus['End'] !=
                                                                  null &&
                                                              mapStatus['End']
                                                          ? FColors.grey8
                                                          : FColors.grey6,
                                                    ],
                                                    onPressed: () {
                                                      if (mapStatus['End'] ==
                                                              null ||
                                                          !mapStatus['End']) {
                                                        return;
                                                      }
                                                      stopGroup(group);
                                                    },
                                                  ),
                                                  FIcon(
                                                    icon: FOutlinedIcons.more,
                                                    color: const <Color>[
                                                      FColors.grey6
                                                    ],
                                                    onPressed: () {
                                                      showmore(group);
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
                              ),
                            ),
                            if (isLoadMore) CircularProgressIndicator()
                          ],
                        ),
            ),
          ),
        ),
      );
}

class TabViewLoading extends StatelessWidget {
  const TabViewLoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (_, __) => Container(
          decoration: BoxDecoration(
            color: FColors.grey1,
            borderRadius: BorderRadius.circular(4),
          ),
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(bottom: 16),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 4),
                      height: 22,
                      width: 100,
                      color: Colors.white,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 4),
                      height: 22,
                      width: 50,
                      color: Colors.white,
                    ),
                  ],
                ),
                FDivider(
                  space: 12,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 4),
                  height: 14,
                  width: 130,
                  color: Colors.white,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 12),
                  height: 14,
                  width: 80,
                  color: Colors.white,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 9),
                  height: 24,
                  width: 220,
                  color: Colors.white,
                ),
                FDivider(),
                Container(
                  margin: EdgeInsets.only(top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FBoundingBox(
                          type: FBoundingBoxType.circle,
                          size: FBoxSize.size24x24,
                          child: Container(color: Colors.white)),
                      FBoundingBox(
                          type: FBoundingBoxType.circle,
                          size: FBoxSize.size24x24,
                          child: Container(color: Colors.white)),
                      FBoundingBox(
                          type: FBoundingBoxType.circle,
                          size: FBoxSize.size24x24,
                          child: Container(color: Colors.white)),
                      FBoundingBox(
                          type: FBoundingBoxType.circle,
                          size: FBoxSize.size24x24,
                          child: Container(color: Colors.white)),
                      FBoundingBox(
                          type: FBoundingBoxType.circle,
                          size: FBoxSize.size24x24,
                          child: Container(color: Colors.white)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
