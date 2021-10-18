import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../F.Utils/LayoutContainWidgetKeepAlive.dart';
import '../../FIS.SYS/Components/ComponentsBase.dart';
import '../../FIS.SYS/Modules/TakerGroups/Actions/TakerDetail/Overview.dart';
import '../../FIS.SYS/Modules/TakerGroups/Actions/TakerDetail/TakerView.dart';
import '../../FIS.SYS/Modules/TakerGroups/TakerGroup.dart';
import '../../FIS.SYS/Skins/KhaoThi/SkinColor.dart';
import '../../FIS.SYS/Skins/Typography.dart';
import '../../FIS.SYS/Styles/StyleBase.dart';
import '../../FIS.SYS/Styles/Typographies.dart';

class TakerDetailScreen extends StatefulWidget {
  final TakerGroup takerGroup;
  const TakerDetailScreen(this.takerGroup);

  @override
  _TakerDetailScreenState createState() => _TakerDetailScreenState();
}

class _TakerDetailScreenState extends State<TakerDetailScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  List<Tab> myTabs = <Tab>[
    Tab(text: 'Tổng quan'),
    Tab(text: 'Thí sinh'),
    // Tab(text: 'Chấm thi'),
  ];

  @override
  void initState() {
    _controller = TabController(vsync: this, length: myTabs.length);
    super.initState();
  }

  final myController = TextEditingController();

  void tabanimateTo() {
    setState(() {
      _controller.animateTo(_controller.index + 1);
    });
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: myTabs.length,
        child: Scaffold(
          backgroundColor: FColors.grey2,
          appBar: FAppBar(
            headerLead: FIconButton(
              icon: FOutlinedIcons.left,
              backgroundColor: FColors.transparent,
              color: FColors.grey9,
              size: FIconButtonSize.size48,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            headerCenter: Container(
              alignment: Alignment.center,
              child: FText(
                '${widget.takerGroup.name}',
                style: FTextStyle.titleModules3,
              ),
            ),
            headerActions: [
              Container(
                width: 48,
              )
            ],
            bottom: Column(
              children: [
                FDivider(),
                Container(
                  child: TabBar(
                    controller: _controller,
                    indicatorColor: SkinColor.primary,
                    labelColor: SkinColor.primary,
                    labelStyle:
                        CustomFont.regular14_22.copyWith(color: FColors.grey7),
                    unselectedLabelStyle:
                        CustomFont.regular14_22.copyWith(color: FColors.grey7),
                    unselectedLabelColor: FColors.grey7,
                    tabs: myTabs,
                  ),
                ),
              ],
            ),
          ),
          body: Container(
            margin: EdgeInsets.only(top: 16),
            child: TabBarView(
              controller: _controller,
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                LayoutContainWidgetKeepAlive(
                  child: OverView(
                    widget.takerGroup,
                    callBack: tabanimateTo,
                  ),
                ),
                LayoutContainWidgetKeepAlive(
                  child: TakerView(widget.takerGroup.id),
                ),

                // if (isShowGroupDeleted) Tab1<TakerGroupDeletedProvider>()
              ],
            ),
          ),
        ),
      );
}
