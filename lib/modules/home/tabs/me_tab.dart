import 'package:cached_network_image/cached_network_image.dart';
import 'package:capusle_rewards/modules/project/project_controller.dart';
import 'package:flutter/material.dart';
import 'package:capusle_rewards/modules/home/home.dart';
import 'package:capusle_rewards/routes/routes.dart';
import 'package:capusle_rewards/shared/shared.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class MeTab extends GetView<HomeController> {
  final ProjectController projectController = Get.find<ProjectController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40),
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: 'info'.tr,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                InkWell(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "my_email".tr,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              controller.user.value?.email ?? "",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xffaeaeae),
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'settings'.tr,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'default_lang'.tr,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xffaeaeae),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 12, right: 12),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: Get.locale?.languageCode == 'en'
                              ? 'English'
                              : '한국어',
                          icon:
                              Icon(Icons.arrow_drop_down, color: Colors.black),
                          onChanged: (String? newValue) {
                            var code = newValue! == 'English' ? 'en' : 'ko';
                            if (newValue != null) {
                              Get.updateLocale(Locale(code));
                            }
                          },
                          items: <String>['English', '한국어']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                alignment: Alignment.center,
                                child:
                                    Text(value, style: TextStyle(fontSize: 18)),
                              ), // 여기에서 Text 스타일을 조정합니다.
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    controller.signout();
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "logout".tr,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xffaeaeae),
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                if (GetPlatform.isAndroid)
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.PRIVACY_POLICY);
                    },
                    child: Container(
                      //Underlined Text clickable
                      child: Center(
                        child: Text(
                          'privacy_policy'.tr,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 16,
                            color: Color(0xffaeaeae),
                          ),
                        ),
                      ),
                    ),
                  ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('delete_account'.tr),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'delete_account_message'.tr,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'delete_warning'.tr,
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('No'),
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                            ),
                            TextButton(
                              child: Text('Yes'),
                              onPressed: () {
                                controller.deleteAccount();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "delete_account".tr,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xffffa3a3),
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xffaeaeae),
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProfileItem(int number, String title) {
    return Column(
      children: [
        Text('$number',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        Text(title),
      ],
    );
  }
}
