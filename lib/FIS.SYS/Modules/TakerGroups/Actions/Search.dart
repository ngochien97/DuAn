import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:khao_thi_gv/FIS.SYS/Core/routes.dart';
import 'package:khao_thi_gv/Khao_thi_GV/RouteNames.dart';

import '../../../../F.Utils/Convert.dart';
import '../../../Components/ComponentsBase.dart';
import '../../../Components/SnackBar.dart';
import '../../../Skins/Icon.dart';
import '../../../Skins/KhaoThi/SkinColor.dart';
import '../../../Skins/Typography.dart';
import '../../../Styles/Colors.dart';
import '../../../Styles/Icons.dart';
import '../../../Styles/StyleBase.dart';
import '../../ConfigKhaoThi.dart';
import '../DA/TakerGroupDA.dart';
import '../TakerGroup.dart';
import '../TakerGroupStatus.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  DateTime fromTime = DateTime.now();
  DateTime dueTime = DateTime.now();
  DateTime toTime = DateTime.now();
  int timeLimit = 0;
  int groupEditId = 0;
  final ScrollController _controller = ScrollController();
  TextEditingController dateCtl = TextEditingController();
  bool isLoadMore = false;
  bool isLoading = false;

  final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm');
  TakerGroupDA takerGroupDA = TakerGroupDA();
  String txtSearch = '';
  Future<void> scrollToLoadMore() async {
    if (isLoadMore) {
      return;
    }

    if (_controller.position.extentAfter < 100) {
      setState(() {
        isLoadMore = true;
      });

      // await Provider.of<T>(context, listen: false).loadMoreData();
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
            builder: (context, setStateChild) => AlertDialog(
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
                          isLoading: isLoading,
                          onPressed: () async {
                            if (isLoading) {
                              return;
                            }
                            setState(() {
                              isLoading = true;
                            });
                            final data =
                                await takerGroupDA.takerGroupStart(group);
                            setState(() {
                              isLoading = false;
                            });

                            if (data.code == 200) {
                              final groupTmp = groups
                                  .where((element) => element.id == group.id)
                                  .first;
                              groupTmp.status = data.takerGroup.status;
                              setState(() {});
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
            builder: (context, setStateChild) => AlertDialog(
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
                              final groupTmp = groups
                                  .where((element) => element.id == group.id)
                                  .first;
                              groupTmp.status = data.takerGroup.status;
                              setState(() {});
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
            builder: (context, setStateChild) => AlertDialog(
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
                              final groupTmp = groups
                                  .where((element) => element.id == group.id)
                                  .first;
                              groupTmp.status = data.takerGroup.status;
                              setState(() {});
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
            builder: (context, setStateChild) => AlertDialog(
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
                              final groupTmp = groups
                                  .where((element) => element.id == group.id)
                                  .first;
                              groupTmp.status = data.takerGroup.status;
                              setState(() {});
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
    if (group.status != TakerGroupStatusBase.moitao) {
      return;
    }
    final contextParent = context;
    showDialog(
        context: context,
        builder: (_) => StatefulBuilder(
            builder: (context, setStateChild) => AlertDialog(
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
                              final groupTmp = groups
                                  .where((element) => element.id == group.id)
                                  .first;
                              groupTmp.status = data.takerGroup.status;
                              setState(() {});
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
            builder: (context, setStateChild) => AlertDialog(
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
                              final groupTmp = groups
                                  .where((element) => element.id == group.id)
                                  .first;
                              groupTmp.status = data.takerGroup.status;
                              setState(() {});
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
                          (group.status == TakerGroupStatusBase.moitao ||
                                  group.status ==
                                      TakerGroupStatusBase.tamDung ||
                                  group.status == TakerGroupStatusBase.daXoa)
                              ? SkinColor.primary
                              : FColors.grey6
                        ],
                      ),
                    ),
                    title: FText('Sửa kíp thi'),
                    backgroundColor: FColors.grey3,
                    onTap: () {
                      if (!(group.status == TakerGroupStatusBase.moitao ||
                          group.status == TakerGroupStatusBase.tamDung ||
                          group.status == TakerGroupStatusBase.daXoa)) {
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
                          builder: (context) => StatefulBuilder(
                              builder: (context, setState) => Container(
                                      child: FBottomSheet(
                                    header: FModal(
                                      title: FText('Sửa kíp thi'),
                                    ),
                                    body: Expanded(
                                      child: Text('a'),
                                    ),
                                  ))));
                    },
                  ),
                  FSpacer.space8px,
                  FListTitle(
                    avatar: FBoundingBox(
                      backgroundColor: FColors.transparent,
                      size: FBoxSize.size32x32,
                      child: FIcon(
                        icon: FOutlinedIcons.qrcode,
                        color: const <Color>[FColors.green6],
                      ),
                    ),
                    title: FText('Mã giám thị'),
                    backgroundColor: FColors.grey3,
                  ),
                  FSpacer.space8px,
                  !(group.status == TakerGroupStatusBase.daXoa)
                      ? FListTitle(
                          avatar: FBoundingBox(
                            backgroundColor: FColors.transparent,
                            size: FBoxSize.size32x32,
                            child: FIcon(
                              icon: FFilledIcons.delete,
                              color: const <Color>[FColors.red6],
                            ),
                          ),
                          title: FText('Xóa kíp thi'),
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
        ),
      ),
    );
  }

  List<TakerGroup> groups = <TakerGroup>[];

  Future search() async {
    //await Future.delayed(Duration(seconds: 2));
    if (txtSearch == '' || txtSearch.length < 2) {
      return <TakerGroup>[];
    }
    final datas = await takerGroupDA.gettestTakerGroupSearch(
        ConfigAPI.testTakerGroupActived, txtSearch, 1, 10);
    final datas1 = await takerGroupDA.gettestTakerGroupSearch(
        ConfigAPI.testTakerGroupClosed, txtSearch, 1, 10);
    final datas2 = await takerGroupDA.gettestTakerGroupSearch(
        ConfigAPI.testTakerGroupDeleted, txtSearch, 1, 10);
    final groupsData = <TakerGroup>[];
    if (datas.code == 200) {
      groupsData.addAll(datas.takerGroups);
    }
    if (datas1.code == 200) {
      groupsData.addAll(datas1.takerGroups);
    }
    if (datas2.code == 200) {
      groupsData.addAll(datas2.takerGroups);
    }
    setState(() {
      groups = groupsData;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(scrollToLoadMore);
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: FColors.grey2,
          appBar: FAppBar(
            bottom: Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: FTextField(
                        backgroundColor: FColors.grey3,
                        autoFocus: true,
                        leftIcon: FOutlinedIcons.search,
                        label: 'Nhập tên kíp thi',
                        onSubmitted: (value) {
                          txtSearch = value;
                          search();
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8),
                    child: FButton(
                      title: 'Hủy',
                      backgroundColor: FColors.transparent,
                      color: SkinColor.primary,
                      block: true,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              await search();
            },
            child: Container(
              margin: EdgeInsets.only(top: 8, left: 16, right: 16),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: _controller,
                      physics: BouncingScrollPhysics(),
                      itemCount: groups.length,
                      itemBuilder: (context, index) {
                        final group = groups[index];
                        final statusColor = getColorStatus(group.status);
                        final mapStatus = takerGroupDA.showAction(group.status);
                        return GestureDetector(
                          onTap: () {
                            CoreRoutes.instance.navigateTo(
                                RouteNames.TAKERGROUPDETAIL,
                                arguments: group);
                          },
                          child: Container(
                            height: 187,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            margin: EdgeInsets.only(bottom: 16),
                            width: MediaQuery.of(context).size.width,
                            color: FColors.grey1,
                            child: FBoundingBox(
                              size: FBoxSize.auto_rectangle,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Container(
                                            child: FText(
                                              '${group.name}',
                                              overflow: TextOverflow.ellipsis,
                                              style: FTextStyle.titleModules5,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Container(
                                                alignment: Alignment.topCenter,
                                                child: FText(
                                                  takerGroupStatus[
                                                      group.status],
                                                  color: statusColor,
                                                ),
                                              ),
                                              FSpacer.hozirontalSpace4px,
                                              Container(
                                                margin: EdgeInsets.only(top: 5),
                                                child: FBoundingBox(
                                                  backgroundColor: statusColor,
                                                  size: FBoxSize.size8x8,
                                                  type: FBoundingBoxType.circle,
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
                                  group.controlMode
                                      ? FText(
                                          'Giờ mở kíp: ${group.getStringTimeOpen}',
                                          style: FTextStyle.subtitle2)
                                      : Container(),
                                  FSpacer.space4px,
                                  FText(
                                    'Giờ đóng kíp: ${group.toTime.format("dd/MM/yyyy, HH:mm")}',
                                    style: FTextStyle.subtitle2,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 12),
                                    child: Row(children: [
                                      FTag(
                                        title: group.controlMode
                                            ? 'Tự động'
                                            : 'Thủ công',
                                        leftIcon: FFilledIcons.clock_circle,
                                        backgroundColor: SkinColor.primary,
                                        color: FColors.grey1,
                                      ),
                                      FSpacer.hozirontalSpace4px,
                                      FTooltip(
                                        message: 'Tổng số thi sinh',
                                        backgroundColor: SkinColor.primary,
                                        child: FTag(
                                          title: '${group.takerCount}',
                                          leftIcon: FFilledIcons.user_multiple,
                                          color: SkinColor.primary,
                                          backgroundColor: FColors.geek_blue1,
                                        ),
                                      ),
                                      FSpacer.hozirontalSpace4px,
                                      FTooltip(
                                        message: 'Thí sinh đã thi',
                                        backgroundColor: FColors.green6,
                                        child: FTag(
                                          title: '${group.takerSubmitCount}',
                                          leftIcon: FFilledIcons.user_check,
                                          color: FColors.green6,
                                          backgroundColor: FColors.cyan1,
                                        ),
                                      ),
                                      FSpacer.hozirontalSpace4px,
                                      FTooltip(
                                        message: 'Thí sinh chưa thi',
                                        backgroundColor: FColors.orange6,
                                        child: FTag(
                                          title:
                                              '${group.takerCount - group.takerSubmitCount}',
                                          leftIcon: FFilledIcons.user_time,
                                          color: FColors.orange6,
                                          backgroundColor: FColors.gold1,
                                        ),
                                      ),
                                    ]),
                                  ),
                                  FDivider(),
                                  Container(
                                    margin: EdgeInsets.only(top: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        FIcon(
                                          icon: FFilledIcons.play_circle,
                                          color: [
                                            mapStatus['Play'] != null &&
                                                    mapStatus['Play']
                                                ? FColors.grey8
                                                : FColors.grey6
                                          ],
                                          onPressed: () {
                                            if (mapStatus['Play'] == null ||
                                                !mapStatus['Play']) {
                                              return;
                                            }
                                            playGroup(group);
                                          },
                                        ),
                                        FIcon(
                                          icon: FFilledIcons.pause_circle,
                                          color: [
                                            mapStatus['Pause'] != null &&
                                                    mapStatus['Pause']
                                                ? FColors.grey8
                                                : FColors.grey6
                                          ],
                                          onPressed: () {
                                            if (mapStatus['Pause'] == null ||
                                                !mapStatus['Pause']) {
                                              return;
                                            }
                                            pauseGroup(group);
                                          },
                                        ),
                                        FIcon(
                                          icon: FFilledIcons.lock,
                                          color: [
                                            mapStatus['Lock'] != null &&
                                                    mapStatus['Lock']
                                                ? FColors.grey8
                                                : FColors.grey6
                                          ],
                                          onPressed: () {
                                            if (mapStatus['Lock'] == null ||
                                                !mapStatus['Lock']) {
                                              return;
                                            }

                                            lockGroup(group);
                                          },
                                        ),
                                        FIcon(
                                          icon: FFilledIcons.engine_start,
                                          color: [
                                            mapStatus['End'] != null &&
                                                    mapStatus['End']
                                                ? FColors.grey8
                                                : FColors.grey6,
                                          ],
                                          onPressed: () {
                                            if (mapStatus['End'] == null ||
                                                !mapStatus['End']) {
                                              return;
                                            }
                                            stopGroup(group);
                                          },
                                        ),
                                        FIcon(
                                          icon: FOutlinedIcons.more,
                                          color: const <Color>[FColors.grey6],
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
