import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../F.Utils/Convert.dart';
import '../../../../Khao_thi_GV/RouteNames.dart';
import '../../../Components/ComponentsBase.dart';
import '../../../Core/routes.dart';
import '../../../Skins/Icon.dart';
import '../../../Skins/Typography.dart';
import '../../../Styles/Colors.dart';
import '../../../Styles/Icons.dart';
import '../../TakerGroups/ClassInfomation.dart';
import '../DA/PresentDA.dart';
import '../Providers/PresentationProvider.dart';

class PresentScreen extends StatefulWidget {
  @override
  _PresentScreenState createState() => _PresentScreenState();
}

class _PresentScreenState extends State<PresentScreen> {
  List<ClassInfomation> classList = [];
  PresentDA presentDA = PresentDA();
  bool isLoading = false;
  String txt = '';
  Future<void> loadData() async {
    if (isLoading) {
      return;
    }
    isLoading = true;

    try {
      final data = await presentDA.getClassHasPresent();
      if (data.code == 200) {
        setState(() {
          classList = data.classes;
        });
      }
    } catch (e) {
      isLoading = false;
    }

    isLoading = false;
  }

  List<ClassInfomation> search() => classList
      .where((element) => element.name
          .newUnicodeToAscii()
          .toLowerCase()
          .contains(txt.newUnicodeToAscii().toLowerCase()))
      .toList();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    final datas = search();

    return Scaffold(
      backgroundColor: FColors.grey2,
      appBar: FAppBar(        
        headerLead: Container(
          width: 48,
        ),
        headerCenter: Container(
            alignment: Alignment.center,
            child: FText('Trình chiếu', style: FTextStyle.titleModules3)),
        headerActions: <Widget>[
          Container(
            width: 48,
          )
        ],
        bottom: Container(
          margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
          child: FTextField(
            size: FTextFieldSize.size40,
            backgroundColor: FColors.grey3,
            label: 'Tìm lớp',
            leftIcon: FOutlinedIcons.search,
            onChanged: (value) {
              setState(() {
                txt = value;
              });
            },
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await loadData();
        },
        child: ListView.builder(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemCount: datas.length,
          itemBuilder: (context, index) => Container(
            margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: FListTitle(
              title: FText(
                datas[index].name,
              ),
              action: [FIcon(icon: FOutlinedIcons.right, size: 16)],
              onTap: () {
                final provider =
                    Provider.of<PresentationProvider>(context, listen: false);
                provider.init(datas[index].id);

                CoreRoutes.instance.navigateTo(RouteNames.PRESENTATION,
                    arguments: datas[index]);
              },
            ),
          ),
        ),
      ),
      // Container(
      //   child: CameraApp(),
      //   height: double.infinity,
      // ),
    );
  }
}
