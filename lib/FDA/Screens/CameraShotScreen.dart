import 'dart:convert';
import 'dart:io';
import 'package:Framework/FDA/screens.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:http/io_client.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scanbot_sdk/cropping_screen_data.dart';
import 'package:scanbot_sdk/scanbot_sdk.dart';
import 'package:scanbot_sdk/scanbot_sdk_models.dart';
import 'package:scanbot_sdk/common_data.dart' as c;

class CameraShotScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  final CameraController controller;

  CameraShotScreen({this.cameras, this.controller});
  @override
  _CameraShotScreenState createState() => _CameraShotScreenState();
}

class _CameraShotScreenState extends State<CameraShotScreen> {
  c.Page page = new c.Page(
    c.DetectionStatus.ERROR_NOTHING_DETECTED,
    null,
    c.ImageFilterType.NONE,
    "test",
    [
      c.PolygonPoint(0, 0),
      c.PolygonPoint(1, 0),
      c.PolygonPoint(1, 1),
      c.PolygonPoint(0, 1),
    ],
    null,
    null,
    null,
    null,
    // Uri.file("file:///storage/emulated/0/DICM/ScreenShots/ss1.png"),
    // Uri.file("file:///storage/emulated/0/DICM/ScreenShots/ss1.png"),
    // Uri.file("file:///storage/emulated/0/DICM/ScreenShots/ss1.png"),
    // Uri.file("file:///storage/emulated/0/DICM/ScreenShots/ss1.png"),
  );

  @override
  void initState() {
    initScanbotSdk();
    super.initState();
    widget.controller.initialize().then((_) {
      if (!mounted) {
        Container();
      }
      setState(() {});
    });
  }

  initScanbotSdk() async {
    final SCANBOT_SDK_LICENSE_KEY = "VaErbLGL/JTwA11Gt/cv28I4OnU45b" +
        "BOzZMm9yLfpihEKo0yJEtq8lW6yuea" +
        "e9uMn+LTHjHs5kZPoGmlhmQLRtMzTg" +
        "1LFKOZLKeiOlWEBNBRl/dy+olzP/NZ" +
        "TH/NCOibq/EMBmZFFoFW8CjiBKiG0G" +
        "TAdHlTfYfyErxdH0Xfkh//9kJdfbKl" +
        "YtVpwR6eDN+6LF8N9wTLkLnqHhLlqd" +
        "uB+qEsJiLU0f332MrhV9oZK65Wmv24" +
        "lQ51s6ohEwbHbpaW/TO/hAdijGfrv0" +
        "lSjR9fP6028H47CT2FuBvY8TsI7wvv" +
        "+71tJ51vJXp2ZUkRjYLY+S1fkzXpmk" +
        "2s7FUoAar/bQ==\nU2NhbmJvdFNESw" +
        "pjb20uZmRpLmdhYmRldGFpbC5HYWJS" +
        "ZXRhaWwKMTYwNDEwMjM5OQo1OTAKMw" +
        "==\n";

    Directory storageDirectory;
    if (Platform.isAndroid) {
      storageDirectory = await getExternalStorageDirectory();
    } else if (Platform.isIOS) {
      storageDirectory = await getApplicationDocumentsDirectory();
    } else {
      throw ("Unsupported platform");
    }
    var customStorageBaseDirectory =
        "${storageDirectory.path}/my-custom-storage";

    var config = ScanbotSdkConfig(
      loggingEnabled:
          true, // Consider switching logging OFF in production builds for security and performance reasons.
      licenseKey: SCANBOT_SDK_LICENSE_KEY,
      imageFormat: c.ImageFormat.JPG,
      imageQuality: 80,
      storageBaseDirectory: customStorageBaseDirectory,
    );

    try {
      await ScanbotSdk.initScanbotSdk(config);
    } catch (e) {
      print(e);
    }
  }

  startCropScreen() async {
    MethodChannel _channel = const MethodChannel('scanbot_sdk');
    try {
      String result = await _channel.invokeMethod("startCroppingScreen", {
        "topBarTitle": "Crop file",
        "cancelButtonTitle": "Cancel",
        "doneButtonTitle": "Save",
        "page": page.toJson(),
      });
      var data = CroppingResult.fromJson(jsonDecode(result));
      setState(() {
        page.polygon = data.page.polygon;
      });

      if (data.operationResult == c.OperationResult.SUCCESS) {
        // Navigator.push(context, MaterialPageRoute(builder => SettingFileScreen()))
        Navigator.pushNamed(context, "setting-file-screen",
            arguments: {"file": data.page.documentImageFileUri});
      }
    } catch (e) {
      print(e);
    }
  }

  onCapture(context) async {
    try {
      Directory storageDirectory;
      if (Platform.isAndroid) {
        storageDirectory = await getExternalStorageDirectory();
      } else if (Platform.isIOS) {
        storageDirectory = await getApplicationDocumentsDirectory();
      } else {
        throw ("Unsupported platform");
      }
      var baseStorageDir =
          "${storageDirectory.path}/my-custom-storage/snapping_pages/test/";
      final filePath = baseStorageDir + "original_image.JPG";
      final preFilePath = baseStorageDir + "original_image_preview.JPG";
      final docPath = baseStorageDir + "document_image.JPG";

      Directory(baseStorageDir).exists().then((isExist) {
        if (!isExist) {
          Directory(baseStorageDir).create(recursive: true);
        }
      });

      try {
        final fileDir = Directory(filePath);
        final preFilePathDir = Directory(preFilePath);
        final docPathDir = Directory(docPath);
        fileDir.deleteSync(recursive: true);
        preFilePathDir.deleteSync(recursive: true);
        docPathDir.deleteSync(recursive: true);
      } catch (e) {
        print(e);
      }

      await widget.controller
          .takePicture(filePath)
          .then((_) => File(filePath).copySync(preFilePath));
      startCropScreen();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FAppBar(
        backgroundColor: FColors.grey9,
        headerLead: FIconButton(
          icon: FOutlinedIcons.thunderbolt,
          size: FIconButtonSize.size48,
          backgroundColor: FColors.transparent,
          onPressed: () {},
          color: FColors.grey1,
        ),
        headerActions: [
          FIconButton(
            icon: FOutlinedIcons.setting,
            size: FIconButtonSize.size48,
            backgroundColor: FColors.transparent,
            onPressed: () {},
            color: FColors.grey1,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: !widget.controller.value.isInitialized
                  ? Container()
                  : AspectRatio(
                      aspectRatio: widget.controller.value.aspectRatio,
                      child: CameraPreview(widget.controller)),
            ),
          ),
          Container(
            height: 100.0,
            color: FColors.grey9,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FIconButton(
                    icon: FOutlinedIcons.close,
                    backgroundColor: FColors.transparent,
                    size: FIconButtonSize.size48,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    color: FColors.grey1,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      onCapture(context);
                    },
                    child: Container(
                      height: 64,
                      width: 64,
                      decoration: BoxDecoration(
                        color: FColors.transparent,
                        border: Border.all(color: FColors.grey1, width: 5.0),
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                      padding: EdgeInsets.all(1.0),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: FColors.grey1,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                  FIconButton(
                    icon: FOutlinedIcons.cloud_upload,
                    backgroundColor: FColors.transparent,
                    size: FIconButtonSize.size48,
                    color: FColors.grey1,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
