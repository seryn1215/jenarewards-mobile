import 'package:flutter/material.dart';
import 'package:capusle_rewards/lang/translation_service.dart';
import 'package:get/get.dart';

class LanguageDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: Get.locale?.languageCode,
      icon: const Icon(Icons.language),
      onChanged: (String? language) {
        if (language != null) {
          Get.updateLocale(Locale(language));
        }
      },
      items: TranslationService.languages
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(value),
            ],
          ),
        );
      }).toList(),
    );
  }
}
