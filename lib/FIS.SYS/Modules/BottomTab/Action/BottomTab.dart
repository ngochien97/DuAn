import 'package:Framework/FDA/CameraShotScreen.dart';
import 'package:Framework/FIS.SYS/Components/BottomSheet.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Components/TabBar.dart';
import 'package:Framework/FIS.SYS/Modules/BottomSheet/Import.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Skins/Skin_FDA.Thue/SkinColors.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class BottomTabBar extends StatefulWidget {
  @override
  _BottomTabBarState createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  List<CameraDescription> cameras;
  CameraController controller;

  @override
  Widget build(BuildContext context) {
    return FTabBar(
      height: 70,
      backgroundColor: FColors.transparent,
      floatingButtonAction: FFloatingButtonAction(
        backgroundColor: FColors.green4,
        icon: FFilledIcons.camera,
        color: FColors.grey1,
        onPressed: () async {
          WidgetsFlutterBinding.ensureInitialized();
          cameras = await availableCameras();
          controller = CameraController(cameras[0], ResolutionPreset.max);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CameraShotScreen(
                        cameras: cameras,
                        controller: controller,
                      )));
        },
      ),
      floatingButtonActionPosition: FFloatingButtonActionPosition.center,
      children: [
        FTabBarItem(
          icon: FOutlinedIcons.cloud_upload,
          color: FColors.grey8,
          title: 'Import',
          onTap: (index) {
            showImportScreen(context);
          },
        ),
        FTabBarItem(
          icon: FOutlinedIcons.folder_open,
          title: 'Recent',
          color: FColors.grey8,
          onTap: (index) {
            Navigator.pushNamed(context, "recent-screen");
          },
        ),
      ],
    );
  }
}
