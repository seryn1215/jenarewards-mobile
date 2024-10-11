import 'package:capusle_rewards/bricks/info_card.dart';
import 'package:capusle_rewards/modules/home/sections/project_section.dart';
import 'package:capusle_rewards/modules/project/project_controller.dart';
import 'package:capusle_rewards/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:capusle_rewards/models/response/users_response.dart';
import 'package:capusle_rewards/modules/home/home.dart';
import 'package:capusle_rewards/shared/constants/colors.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../sections/header_section.dart';

class MainTab extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        child: _buildLayout(),
        onRefresh: () {
          controller.loadMe();
          final projectController = Get.find<ProjectController>();
          projectController.loadProjects();
          projectController.loadMyActivities();
          return Future.value(true);
        },
      ),
    );
  }

  List<Datum>? get data {
    return controller.users.value == null ? [] : controller.users.value!.data;
  }

  Widget _buildLayout() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xff00dd8c), // 티파니색
                  Color(0xff375bff), // 블루
                ],
              ),
              image: DecorationImage(
                image: AssetImage("assets/images/logo_bg.png"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                Obx(
                  () => Row(
                    children: [
                      ClipOval(
                        child: Image.network(
                          controller.user.value?.photoUrl ?? "",
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.account_circle,
                              size: 80,
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Icon(Icons.account_circle, size: 80);
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("hello".tr + " 👋🏻",
                                style: TextStyle(
                                  fontSize: 20,
                                )),
                            Text(controller.user.value?.name ?? "",
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          // color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            controller.getAccountLevelIcon(),
                            style: TextStyle(
                              fontSize: 40,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: (controller.quickStats)
                          .map((data) => Container(
                                width: Get.size.width * 0.23,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    Text(data["icon"],
                                        style: TextStyle(fontSize: 32)),
                                    SizedBox(height: 4),
                                    Text(data["count"],
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                    Text(data["name"],
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xffaeaeae))),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 32),
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.HOME + Routes.JOIN_PROJECT);
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xff000000),
                onPrimary: Color(0xffffffff),
                padding: EdgeInsets.all(24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.qr_code_scanner,
                    size: 32,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'qr_scan'.tr,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ProjectSection()
        ],
      ),
    );
  }
}
