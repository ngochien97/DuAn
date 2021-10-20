import 'dart:convert';
import 'dart:io';

import 'package:Framework/FDA/Screens/RecentScreen.dart';
import 'package:Framework/FDA/screens.dart';
import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Components/PopupActionSheetBar.dart';
import 'package:Framework/FIS.SYS/Components/SnackBar.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/StyleBase.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/services.dart';
import 'package:Framework/ui/progress_dialog.dart';
import 'package:Framework/FIS.SYS/Components/TabBar.dart';
import 'package:Framework/FIS.SYS/Skins/Skin_FDA.Thue/SkinColors.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:Framework/ui/utils.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:Framework/pages_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scanbot_sdk/barcode_scanning_data.dart';
import 'package:scanbot_sdk/cropping_screen_data.dart';
import 'package:scanbot_sdk/document_scan_data.dart';
import 'package:scanbot_sdk/ehic_scanning_data.dart';
import 'package:scanbot_sdk/mrz_scanning_data.dart';
import 'package:scanbot_sdk/scanbot_sdk.dart';
import 'package:scanbot_sdk/scanbot_sdk_models.dart';
import 'package:scanbot_sdk/scanbot_sdk_ui.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../pages_repository.dart';
import 'package:scanbot_sdk/common_data.dart' as c;
import 'package:path/path.dart' as path;

class BottomTabBar extends StatefulWidget {
  @override
  _BottomTabBarState createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  List<CameraDescription> cameras;
  CameraController controller;
  PageRepository _pageRepository = PageRepository();

  @override
  void initState() {
    super.initState();
    initScanbotSdk();
  }

  @override
  Widget build(BuildContext context) {
    return FTabBar(
      backgroundColor: SkinColor.backTransparent,
      floatingButtonAction: FFloatingButtonAction(
        // backgroundColor: FColors.green4,
        // icon: FFilledIcons.camera,
        // color: FColors.grey1,
        onPressed: () async {
          startDocumentScanning();
        },
        action: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            gradient: FColors.gradientgreen,
          ),
          alignment: Alignment.center,
          child: FIcon(
            icon: FFilledIcons.camera,
            size: 32.0,
            color: [FColors.grey1, FColors.transparent],
          ),
        ),
      ),
      floatingButtonActionPosition: FFloatingButtonActionPosition.center,
      children: [
        FTabBarItem(
          icon: FOutlinedIcons.cloud_upload,
          color: FColors.grey8,
          title: 'Import',
          onTap: (index) {
            showImportSelection();
            // importImage();
          },
        ),
        FTabBarItem(
          icon: FOutlinedIcons.folder_open,
          title: 'Recent',
          color: FColors.grey8,
          onTap: (index) {
            gotoImagesView();
          },
        ),
      ],
    );
  }

  final String licenseKey = "dy/MdmegMr40aL6pJ+C8ANj7zLVeZK" +
      "Uwffh/rk24V+biU8yTwy6UA02n85HN" +
      "gGn6o7dRLieMm6BRlRoRbtJEBVjBm/" +
      "ry63D8dpOGAm4cZKFmJnoO6auaSrne" +
      "qWGNd9gIEO+xhA/QPLJVo/R4yjhWgf" +
      "HeaX3eU87JmnfVGejzg9AP+Zi7JrYf" +
      "E4zw54s2s164J7YIWOZc/1bwGR3MHu" +
      "QAzSFXxTtTHcGsceSo9Qf4lRKBh8LU" +
      "ibBin+NJb5ciOfA97ztHY10aQwxy6P" +
      "bRFY9JM1qMNTmsDrslvHkhzudFTeV0" +
      "2V752Vy+fXF3AorKLRM8yitHrwejEr" +
      "ykBa/N35aIlw==\nU2NhbmJvdFNESw" +
      "pjb20uZmlzLmZkYXRodWUKMTYwNTQ4" +
      "NDc5OQoyMDk3MTUxCjM=\n";

  initScanbotSdk() async {
    // Consider adjusting this optional storageBaseDirectory - see the comments below.
    var customStorageBaseDirectory = await getDemoStorageBaseDirectory();

    var config = ScanbotSdkConfig(
      loggingEnabled: true,
      // Consider switching logging OFF in production builds for security and performance reasons.
      licenseKey: licenseKey,
      // imageFormat: ImageFormat.PNG,
      imageQuality: 80,
      storageBaseDirectory: customStorageBaseDirectory,
    );

    try {
      await ScanbotSdk.initScanbotSdk(config);
    } catch (e) {
      print(e);
    }
  }

  Future<String> getDemoStorageBaseDirectory() async {
    Directory storageDirectory;
    if (Platform.isAndroid) {
      storageDirectory = await getExternalStorageDirectory();
    } else if (Platform.isIOS) {
      storageDirectory = await getApplicationDocumentsDirectory();
    } else {
      throw ("Unsupported platform");
    }

    return "${storageDirectory.path}/my-custom-storage";
  }

  getOcrConfigs() async {
    try {
      var result = await ScanbotSdk.getOcrConfigs();
      showAlertDialog(context, jsonEncode(result), title: "OCR Configs");
    } catch (e) {
      print(e);
      showAlertDialog(context, "Error getting license status");
    }
  }

  getLicenseStatus() async {
    try {
      var result = await ScanbotSdk.getLicenseStatus();
      showAlertDialog(context, jsonEncode(result), title: "License Status");
    } catch (e) {
      print(e);
      showAlertDialog(context, "Error getting OCR configs");
    }
  }

  showImportSelection() {
    showModalBottomSheet(
      elevation: 0,
      isDismissible: true,
      enableDrag: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) => SafeArea(
          child: FBottomSheet(
            header: FModal(
              title: FText("Import", style: FTextStyle.titleModules3),
            ),
            body: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FListTitle(
                    title: FText("Import từ photo"),
                    height: 48,
                    avatar: FBoundingBox(
                      size: FBoxSize.size32x32,
                      type: FBoundingBoxType.circle,
                      backgroundColor: FColors.green1,
                      child: FIcon(
                        icon: FOutlinedIcons.picture,
                        color: [FColors.green6],
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      importImage();
                    },
                  ),
                  FSpacer.space16px,
                  // FListTitle(
                  //   title: FText("Import từ file"),
                  //   height: 48,
                  //   avatar: FBoundingBox(
                  //     size: FBoxSize.size32x32,
                  //     type: FBoundingBoxType.circle,
                  //     backgroundColor: FColors.green1,
                  //     child: FIcon(
                  //       icon: FOutlinedIcons.document,
                  //       color: [FColors.green6],
                  //     ),
                  //   ),
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //     importFile();
                  //   },
                  // ),
                  FSpacer.space16px,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  importImage() async {
    try {
      FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );
      if (result.count == 1) {
        // var file = File(result.paths[0]).lengthSync() / (1024 * 1024);
        // if (file > 3) {
        //   showFSnackBar(
        //     context,
        //     FSnackBar(
        //       position: FlushbarPosition.TOP,
        //       icon: FIcon(
        //         icon: FFilledIcons.check_circle,
        //         color: [FColors.grey1, FColors.transparent],
        //         size: 24.0,
        //       ),
        //       message: FText(
        //         'Dung lượng file không được vượt quá 3Mb.',
        //         color: FColors.grey1,
        //       ),
        //       borderRadius: 8.0,
        //       backgroundColor: FColors.red6,
        //       margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        //     ),
        //   );
        // } else {
        var page = await createPage(Uri.file(result.paths[0]));
        startCropScreen(page);
        // }
      } else {
        if (result.count > 1) {
          // var file = File(result.paths[0]).lengthSync() / (1024 * 1024);
          // if (file > 30) {
          //   showFSnackBar(
          //     context,
          //     FSnackBar(
          //       position: FlushbarPosition.TOP,
          //       icon: FIcon(
          //         icon: FFilledIcons.check_circle,
          //         color: [FColors.grey1, FColors.transparent],
          //         size: 24.0,
          //       ),
          //       message: FText(
          //         'Dung lượng file không được vượt quá 30Mb.',
          //         color: FColors.grey1,
          //       ),
          //       borderRadius: 8.0,
          //       backgroundColor: FColors.red6,
          //       margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          //     ),
          //   );
          // } else {
          result.paths.forEach((el) async {
            await createPage(Uri.file(el));
          });
          gotoImagesView();
          // }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  importFile() async {
    try {
      FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ["pdf", "PDF"],
        allowMultiple: true,
      );
      var x = await getDemoStorageBaseDirectory();
      x = x.replaceAll('my-custom-storage', 'pdffiles');
      var isExists = await Directory(x).exists();
      if (!isExists) {
        Directory(x).create(recursive: true);
        print(1);
      }
      // File result = await _result.copy('${storageDirectory.path}/filename.pdf');

      result.paths.forEach((element) async {
        // File(element).copySync(x);
        await File(element).copy(x);
        // File result = await File(element).copy(x);
      });

      gotoImagesView();
      // }
    } catch (e) {
      print(e);
    }
  }

  createPage(Uri uri) async {
    if (!await checkLicenseStatus(context)) {
      return;
    }

    var dialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    dialog.style(message: "Loading...");
    dialog.show();
    try {
      var page = await ScanbotSdk.createPage(uri, false);
      page = await ScanbotSdk.detectDocument(page);
      this._pageRepository.addPage(page);
      return page;
    } catch (e) {
      print(e);
    } finally {
      dialog.hide();
    }
  }

  startDocumentScanning() async {
    if (!await checkLicenseStatus(context)) {
      return;
    }

    DocumentScanningResult result;
    try {
      var config = DocumentScannerConfiguration(
        autoSnappingSensitivity: 1,
        ignoreBadAspectRatio: true,
        multiPageEnabled: false,
        autoSnappingEnabled: false,
        autoSnappingButtonTitle: "Tự động",
        multiPageButtonTitle: "Nhiều ảnh",
        cameraPreviewMode: c.CameraPreviewMode.FILL_IN,
        orientationLockMode: c.CameraOrientationMode.PORTRAIT,
        cancelButtonTitle: "Huỷ",
        pageCounterButtonTitle: "%d ảnh",
        textHintBadAngles: "Góc xấu",
        textHintBadAspectRatio: "Tỉ lệ ảnh xấu",
        textHintEnergySavingActive: "Tiết kiệm pin bật",
        textHintNothingDetected: "Không phát hiện",
        textHintOK: "Ok",
        textHintOffCenter: "Lệch tâm",
        textHintTooDark: "Thiếu sáng",
        textHintTooNoisy: "Quá ồn",
        textHintTooSmall: "Quá nhỏ",
      );
      result = await ScanbotSdkUi.startDocumentScanner(config);
    } catch (e) {
      print(e);
    }

    if (isOperationSuccessful(result)) {
      _pageRepository.addPages(result.pages);
      if (result.pages.length == 1) {
        startCropScreen(result.pages[0]);
      } else {
        gotoImagesView();
      }
    }
  }

  startCropScreen(c.Page page) async {
    MethodChannel _channel = const MethodChannel('scanbot_sdk');
    try {
      String result = await _channel.invokeMethod("startCroppingScreen", {
        "topBarTitle": "Crop file",
        "cancelButtonTitle": "Huỷ",
        "doneButtonTitle": "Lưu",
        "page": page.toJson(),
      });
      var data = CroppingResult.fromJson(jsonDecode(result));
      setState(() {
        page.polygon = data.page.polygon;
      });

      if (data.operationResult == c.OperationResult.SUCCESS) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SettingFileScreen(
              fileUri: data.page.documentImageFileUri
                  .toString()
                  .replaceFirst("file://", ""),
            ),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  // startBarcodeScanner() async {
  //   if (!await checkLicenseStatus(context)) {
  //     return;
  //   }
  //
  //   try {
  //     var config = BarcodeScannerConfiguration(
  //       topBarBackgroundColor: Colors.blue,
  //       finderTextHint:
  //           "Please align any supported barcode in the frame to scan it.",
  //       // ...
  //     );
  //     var result = await ScanbotSdkUi.startBarcodeScanner(config);
  //     _showBarcodeScanningResult(result);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // startQRScanner() async {
  //   if (!await checkLicenseStatus(context)) {
  //     return;
  //   }
  //
  //   try {
  //     var config = BarcodeScannerConfiguration(
  //       barcodeFormats: [BarcodeFormat.QR_CODE],
  //       finderTextHint: "Please align a QR code in the frame to scan it.",
  //       // ...
  //     );
  //     var result = await ScanbotSdkUi.startBarcodeScanner(config);
  //     _showBarcodeScanningResult(result);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // _showBarcodeScanningResult(final BarcodeScanningResult result) {
  //   if (isOperationSuccessful(result)) {
  //     showAlertDialog(
  //         context,
  //         "Format: " +
  //             result.barcodeFormat.toString() +
  //             "\nValue: " +
  //             result.text,
  //         title: "Barcode Result:");
  //   }
  // }

  startEhicScanner() async {
    if (!await checkLicenseStatus(context)) {
      return;
    }

    HealthInsuranceCardRecognitionResult result;
    try {
      var config = HealthInsuranceScannerConfiguration(
        topBarBackgroundColor: Colors.blue,
        topBarButtonsColor: Colors.white70,
        // ...
      );
      result = await ScanbotSdkUi.startEhicScanner(config);
    } catch (e) {
      print(e);
    }

    if (isOperationSuccessful(result) && result?.fields != null) {
      var concatenate = StringBuffer();
      result.fields
          .map((field) =>
              "${field.type.toString().replaceAll("HealthInsuranceCardFieldType.", "")}:${field.value}\n")
          .forEach((s) {
        concatenate.write(s);
      });
      showAlertDialog(context, concatenate.toString());
    }
  }

  startMRZScanner() async {
    if (!await checkLicenseStatus(context)) {
      return;
    }

    MrzScanningResult result;
    try {
      var config = MrzScannerConfiguration(
        topBarBackgroundColor: Colors.blue,
        // ...
      );
      result = await ScanbotSdkUi.startMrzScanner(config);
    } catch (e) {
      print(e);
    }

    if (isOperationSuccessful(result)) {
      var concatenate = StringBuffer();
      result.fields
          .map((field) =>
              "${field.name.toString().replaceAll("MRZFieldName.", "")}:${field.value}\n")
          .forEach((s) {
        concatenate.write(s);
      });
      showAlertDialog(context, concatenate.toString());
    }
  }

  gotoImagesView() async {
    imageCache.clear();
    return Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => RecentScreen()),
    );
  }
}
