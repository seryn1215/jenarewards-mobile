import 'dart:io';
import 'package:flutter/material.dart';
import 'package:capusle_rewards/modules/auth/auth.dart';
import 'package:capusle_rewards/shared/AppSpacing.dart';
import 'package:get/get.dart';

class AuthScreen extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/green_logo.png"),
                SizedBox(height: 50),
                _buildLanguageDropdown(),
                SizedBox(height: 20),
                _buildGoogleSignInButton(),
                SizedBox(height: 20),
                if (Platform.isIOS) _buildAppleSignInButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageDropdown() {
    var code = Get.locale?.languageCode ?? 'ko';
    var languages = ['English', '한국어'];
    String _selectedLanguage = languages[code == 'en' ? 0 : 1];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Color(0xffe1e1e1), width: 1),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 12, right: 12),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: _selectedLanguage,
              icon: Icon(Icons.arrow_drop_down, color: Colors.black),
              onChanged: (String? newValue) {
                code = newValue! == 'English' ? 'en' : 'ko';
                Get.updateLocale(Locale(code));
              },
              items: <String>['English', '한국어']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(value, style: TextStyle(fontSize: 18)),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleSignInButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: () => controller.signInWithGoogle(),
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Colors.black,
          padding: EdgeInsets.all(24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          minimumSize: Size(double.infinity, 50),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset('assets/images/google.png', height: 20),
            SizedBox(width: 10),
            Text('google_sign_in'.tr),
          ],
        ),
      ),
    );
  }

  Widget _buildAppleSignInButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: () => controller.signInWithApple(),
        style: ElevatedButton.styleFrom(
          primary: Colors.black,
          onPrimary: Colors.white,
          padding: EdgeInsets.all(24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          minimumSize: Size(double.infinity, 50),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset('assets/images/apple.png', height: 20),
            SizedBox(width: 10),
            Text('apple_sign_in'.tr),
          ],
        ),
      ),
    );
  }
}
