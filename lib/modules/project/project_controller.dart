import 'package:capusle_rewards/api/api_repository.dart';
import 'package:capusle_rewards/models/activity.dart';
import 'package:capusle_rewards/models/project.dart';
import 'package:capusle_rewards/modules/auth/auth.dart';
import 'package:capusle_rewards/modules/db/database_controller.dart';
import 'package:capusle_rewards/modules/home/home.dart';
import 'package:capusle_rewards/shared/storage/storage_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ProjectController extends GetxController {
  final RxBool loadingProjects = RxBool(false);
  final RxList<Project> projects = <Project>[].obs;
  final RxList<Activity> activities = <Activity>[].obs;
  final RxList<Activity> myActivities = <Activity>[].obs;
  final Rx<Project> project = Rx<Project>(Project(
      id: 1,
      name: '',
      endDate: DateTime(1993),
      slug: '',
      qrCode: '',
      activityCount: 0,
      startDate: DateTime(1993),
      maxParticipants: 0));

  @override
  void onInit() {
    super.onInit();

    loadProjects();
    loadMyActivities();
  }

  void createProject({
    required String title,
    required String description,
    required DateTime deadline,
  }) {
    loadingProjects.value = true;
    var dbController = Get.find<DatabaseController>();
    var uid = StorageUtil.get('uid');

    //Auto id generation in firebase
    //Convert deadline to Timestamp firestore

    var deadLineTimestamp = Timestamp.fromDate(deadline);

    // dbController.addProject(project);
    Get.back();
    loadProjects();
  }

  Future loadProjects() async {
    loadingProjects.value = true;
    var apiRepo = Get.find<ApiRepository>();
    var response = await apiRepo.getProjects();
    print("Response: $response");
    if (response.isRight) {
      projects.value = response.right.projects;
    } else {
      print(response.left);
    }
    loadingProjects.value = false;
  }

  void selectedProject(Project project) {
    this.project.value = project;
    loadActivities(project.slug);
  }

  void deleteProject(Project project) async {
    var apiRepo = Get.find<ApiRepository>();
    await apiRepo.leaveProject(project.slug);

    loadProjects();
    Get.find<HomeController>().loadMe();
  }

  Future joinProject(String slug, String timezone) async {
    var apiRepo = Get.find<ApiRepository>();
    var response = await apiRepo.joinProject(slug, timezone);
    print("Response: ${response.toString()}");
    if (response.isRight) {
      loadProjects();
    } else {
      loadProjects();
      print(response.left);
      return response.left;
    }
  }

  Future joinActivity(String id, String timezone) async {
    var apiRepo = Get.find<ApiRepository>();
    var response = await apiRepo.joinActivity(id, timezone);
    print("Response: ${response.toString()}");
    if (response.isRight) {
      loadProjects();
      loadMyActivities();
    } else {
      loadProjects();
      loadMyActivities();

      print(response.left);
      return response.left;
    }
  }

  Future loadActivities(String slug) async {
    loadingProjects.value = true;
    activities.value = [];
    var apiRepo = Get.find<ApiRepository>();
    var response = await apiRepo.getProjectActivities(slug);
    print("Response: ${response.toString()}");

    loadingProjects.value = false;

    if (response.isRight) {
      activities.value = response.right.activities;
    } else {
      print(response.left);
    }
  }

  Future loadMyActivities() async {
    try {
      loadingProjects.value = myActivities.length == 0;
      myActivities.value = [];
      var apiRepo = Get.find<ApiRepository>();
      var response = await apiRepo.getUserActivities();

      loadingProjects.value = false;

      if (response.isRight) {
        print("Response: ${response.toString()}");
        myActivities.value = response.right.activities;
      } else {
        print(response.left);
      }

      // loadingProjects.value = false;
    } catch (e) {
      loadingProjects.value = false;
      print(e);
    }
  }
}
