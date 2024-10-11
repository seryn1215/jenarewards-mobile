import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/privacy_policy_controller.dart';

class PrivacyPolicyView extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('privacy_policy'.tr),
          centerTitle: true,
        ),
        body: InAppWebView(
            //bypass ssl certificate
            onReceivedServerTrustAuthRequest: (controller, challenge) {
              return Future.value(ServerTrustAuthResponse(
                  action: ServerTrustAuthResponseAction.PROCEED));
            },
            initialUrlRequest: URLRequest(
              url: Uri.parse("https://app.jenatree.com/privacy-policy/"),
            )));
  }
}
