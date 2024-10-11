import 'package:capusle_rewards/bricks/fancy_button.dart';
import 'package:capusle_rewards/modules/home/home_controller.dart';
import 'package:capusle_rewards/modules/project/project_controller.dart';
import 'package:capusle_rewards/routes/routes.dart';
import 'package:capusle_rewards/shared/widgets/project_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectSection extends StatelessWidget {
  final ProjectController controller = Get.find<ProjectController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: Obx(
              () => RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'my_projects'.tr + '\n',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text:
                          '${controller.projects.length}' + ' ' + 'projects'.tr,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Color(0xffaeaeae),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //Hint showing swipe to delete

          Obx(
            () => controller.loadingProjects.value
                ? Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (controller.projects.isNotEmpty) ...[
                        // Text(
                        //   '(Swipe to delete)',
                        //   style: TextStyle(fontSize: 12, color: Colors.grey),
                        // ),

                        for (var project in controller.projects)
                          Dismissible(
                            key: Key("${project.id}"),
                            background: Container(
                              color: Colors.red,
                              child: Align(
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.delete,
                                  size: 100,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onDismissed: (direction) {
                              // controller.deleteProject(project);

                              Get.showSnackbar(GetSnackBar(
                                message: 'contact_admin_for_remove'.tr,
                                duration: Duration(seconds: 2),
                              ));
                            },
                            child: ProjectCard(
                              title: project.name,
                              description: project.name,
                              progress: project.maxParticipants,
                              coins: project.coins,
                              total: project.activityCount,
                              inProgress: project.inProgress,
                              startDate: project.startDate,
                              endDate: project.endDate,
                              onTap: () {
                                Get.find<ProjectController>()
                                    .selectedProject(project);
                                Get.toNamed(Routes.HOME + Routes.PROJECT_DETAIL,
                                    arguments: project);
                              },
                            ),
                          )
                      ] else
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text('no_projects'.tr),
                        ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
