import 'package:flutter/material.dart';
import 'package:capusle_rewards/shared/AppSpacing.dart';
import 'package:capusle_rewards/shared/shared.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final AuthController controller = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GradientBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: CommonWidget.appBar(
            context,
            'sign_in'.tr,
            Icons.arrow_back,
            Colors.white,
          ),
          body: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 35.0),
            child: _buildForms(context),
          ),
        ),
      ],
    );
  }

  Widget _buildForms(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CommonWidget.rowHeight(),
            ElevatedButton(
              onPressed: () {
                controller.signInWithFacebook();
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  padding: EdgeInsets.symmetric(
                      vertical: AppSpacing.xLarge.toHeight)),
              child: Text('facebook_sign_in'.tr,
                  style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle Google login
                controller.signInWithGoogle();
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  padding: EdgeInsets.symmetric(
                      vertical: AppSpacing.xLarge.toHeight)),
              child: Text('google_sign_in'.tr,
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
