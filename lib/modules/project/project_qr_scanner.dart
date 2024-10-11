import 'dart:io';

import 'package:capusle_rewards/modules/home/home.dart';
import 'package:capusle_rewards/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'project_controller.dart';

class ProjectQrScanner extends StatefulWidget {
  @override
  _ProjectQrScannerState createState() => _ProjectQrScannerState();
}

class _ProjectQrScannerState extends State<ProjectQrScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scan QR Code',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        shadowColor: Colors.transparent,
        backgroundColor: Color(0xff375bff),
      ),
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      // pause camera scanning after detecting the code
      controller.stopCamera();
      // Handle the scanned QR code
      final qrCodeValue = scanData.code;
      print("QR Code Value: $qrCodeValue");
      // #slice after /
      final parts = qrCodeValue?.split(":");
      print("info:" + parts.toString());

      if (parts == null || parts.length != 2) {
        Get.snackbar("error".tr, "invalid_qr_code".tr);

        return;
      }

      final type = parts[0];
      final path = parts[1];

      if (type != "activity_code" && type != "join_project") {
        Get.snackbar("error".tr, "invalid_qr_code".tr);

        return;
      }

      var projectController = Get.find<ProjectController>();
      final timezone = await FlutterNativeTimezone.getLocalTimezone();
      var error;
      if (type == "activity_code")
        error = await projectController.joinActivity(path, timezone);
      else
        error = projectController.joinProject(path, timezone);
      final homeController = Get.find<HomeController>();
      await homeController.loadMe();

      if (error != null) {
        // Get.snackbar("error".tr,
        //     error.error != null ? error.error! : "error_occured".tr);
        Get.offAndToNamed(Routes.HOME);
        return;
      }
      if (type == "activity_code")
        Get.snackbar("success".tr, "activity_joined".tr);
      else
        Get.snackbar("success".tr, "project_joined".tr);

      Get.offAndToNamed(Routes.HOME);
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
