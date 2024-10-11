import 'package:flutter/material.dart';
import 'package:capusle_rewards/modules/auth/auth.dart';
import 'package:capusle_rewards/shared/AppSpacing.dart';
import 'package:capusle_rewards/shared/shared.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
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
            'sign_up'.tr,
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
                // Handle Facebook login
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  padding: EdgeInsets.symmetric(
                      vertical: AppSpacing.xLarge.toHeight)),
              child: Text('facebook_sign_up'.tr,
                  style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle Google login
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  padding: EdgeInsets.symmetric(
                      vertical: AppSpacing.xLarge.toHeight)),
              child: Text('google_sign_up'.tr,
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
