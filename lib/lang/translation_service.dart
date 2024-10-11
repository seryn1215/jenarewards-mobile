import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'en_US.dart';
import 'ko_KR.dart';

class TranslationService extends Translations {
  static Locale? get locale => Get.deviceLocale;
  static List<String> languages = ['en', 'ko'];
  static final fallbackLocale = Locale('en', 'US');
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en_US,
        'ko_KR': ko_KR,
      };
}
