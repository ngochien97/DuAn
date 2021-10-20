import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:Framework/FDA/crop_painter.dart';
import 'package:Framework/FDA/screens.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:flutter/cupertino.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Components/ToolBar.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scanbot_sdk/common_data.dart' as c;
import 'package:scanbot_sdk/cropping_screen_data.dart';
import 'package:scanbot_sdk/scanbot_sdk.dart';
import 'package:scanbot_sdk/scanbot_sdk_models.dart';
import 'package:scanbot_sdk/scanbot_sdk_ui.dart';

class CropFileScreen extends StatefulWidget {
  final String file;
  CropFileScreen({this.file});
  @override
  _CropFileScreenState createState() => _CropFileScreenState();
}

class _CropFileScreenState extends State<CropFileScreen> {
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
  );

  @override
  void initState() {
    initScanbotSdk();
    startCropScreen();
    super.initState();
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
    storageDirectory = await getExternalStorageDirectory();
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
      var data = jsonDecode(result);
      List<c.PolygonPoint> polygon = [];
      for (var element in data["page"]["polygon"]) {
        polygon.add(new c.PolygonPoint(element["x"], element["y"]));
      }
      setState(() {
        page.polygon = polygon;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FColors.grey3,
      appBar: FAppBar(
        headerLead: FButton(
            block: true,
            buttonStyle: FButtonStyle.textAction,
            leftIcon: FOutlinedIcons.close,
            size: FButtonSize.size48,
            backgroundColor: FColors.transparent,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: FColors.grey9,
            onPressed: () {
              Navigator.pop(context);
            }),
        headerCenter: Center(
          child: FText(
            "Crop file",
            style: FTextStyle.titleModules3,
          ),
        ),
      ),
      body: Column(
        children: [
          FlatButton(
            child: Text("Invoke"),
            onPressed: startCropScreen,
          ),
        ],
      ),
    );
  }
}
