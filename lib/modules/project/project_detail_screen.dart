import 'package:capusle_rewards/modules/project/project_controller.dart';
import 'package:capusle_rewards/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../shared/utils/utils.dart';
import '../../shared/widgets/activity_card.dart';

class ProjectDetailPage extends GetView<ProjectController> {
  const ProjectDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //status bar color

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        shadowColor: Colors.transparent,
        backgroundColor: Color(0xff375bff),
        title: Obx(() => Text(controller.project.value.name,
            style: TextStyle(color: Colors.white, fontSize: 20))),
      ),
      body: Obx(() => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.project.value.name,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "+ ${controller.project.value.coins} 🟡",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xffF43939),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "from".tr + ": admin", // admin id
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff747474),
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "duration : ${DateFormat('yyyy/MM/dd').format(controller.project.value.startDate)}~${DateFormat('yyyy/MM/dd').format(controller.project.value.endDate)}",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff747474),
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Expanded(child: activitySection()),
              ],
            ),
          )),
    );
  }

  Widget projectDetailSection(String title, String detail) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              "$title:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              detail,
              style: TextStyle(fontSize: 16.0),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget activitySection() {
    return controller.activities.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "reward_history".tr + " (${controller.activities.length})",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.activities.length,
                  itemBuilder: (context, index) {
                    return ActivityCard(
                      isNotification: false,
                      activity: controller.activities[index],
                    );
                  },
                ),
              ),
            ],
          )
        : Container();
  }
}
