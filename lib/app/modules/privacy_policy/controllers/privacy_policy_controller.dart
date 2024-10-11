import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyController extends GetxController {
  //TODO: Implement PrivacyPolicyController

  final WebViewController controller = WebViewController();

  final count = 0.obs;
  @override
  void onInit() {
    controller
        .loadRequest(Uri.parse("https://app.jenatree.com/privacy-policy/"));

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
