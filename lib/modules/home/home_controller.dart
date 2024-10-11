import 'dart:math';

import 'package:capusle_rewards/api/api.dart';
import 'package:capusle_rewards/models/project.dart';
import 'package:capusle_rewards/models/response/users_response.dart';
import 'package:capusle_rewards/models/user.dart';
import 'package:capusle_rewards/modules/auth/auth.dart';
import 'package:capusle_rewards/modules/db/database_controller.dart';
import 'package:capusle_rewards/modules/home/home.dart';
import 'package:capusle_rewards/shared/shared.dart';
import 'package:capusle_rewards/shared/storage/storage_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../project/project_controller.dart';

class HomeController extends GetxController {
  final ApiRepository apiRepository;

  HomeController({required this.apiRepository});

  var currentTab = MainTabs.home.obs;
  var users = Rxn<UsersResponse>();
  var user = Rxn<User>();

  late MainTab mainTab;
  late DiscoverTab discoverTab;
  late ResourceTab resourceTab;
  late InboxTab inboxTab;
  late MeTab meTab;

  final RxInt earnedPoints = RxInt(10);
  final RxInt redeemedPoints = RxInt(200);

  final RxList quickStats = RxList.empty();

  @override
  void onInit() async {
    super.onInit();

    mainTab = MainTab();
    loadMe();

    discoverTab = DiscoverTab();
    resourceTab = ResourceTab();
    inboxTab = InboxTab();
    meTab = MeTab();

    quickStats.value = [
      {
        "icon": "🚩",
        "name": "projects".tr,
        "count": "0",
      },
      {
        "icon": "🟡",
        "name": "rewards".tr,
        "count": "0",
      },
      {
        "icon": "🗒️",
        "name": "completed".tr,
        "count": "0",
      }
    ].obs;
  }

  Future<void> loadMe() async {
    final result = await apiRepository.getMe();
    result.fold((left) => print(left.error), (right) {
      user.value = right;
    });

    updateQuickStats();
  }

  void signout() {
    Get.find<AuthController>().signOut();
  }

  void switchTab(index) {
    var tab = _getCurrentTab(index);
    currentTab.value = tab;
  }

  int getCurrentIndex(MainTabs tab) {
    switch (tab) {
      case MainTabs.home:
        return 0;
      case MainTabs.discover:
        return 1;
      // case MainTabs.resource:
      //   return 2;
      case MainTabs.inbox:
        return 2;
      case MainTabs.me:
        return 3;
      default:
        return 0;
    }
  }

  MainTabs _getCurrentTab(int index) {
    switch (index) {
      case 0:
        return MainTabs.home;
      case 1:
        return MainTabs.discover;
      // case 2:
      //   return MainTabs.resource;
      case 2:
        return MainTabs.inbox;
      case 3:
        return MainTabs.me;
      default:
        return MainTabs.home;
    }
  }

  void deleteAccount() {
    Get.find<AuthController>().deleteAccount();
  }

  String getAccountLevelName() {
    //Bronze, Silver, Gold
    var coins = user.value?.coins ?? 0;
    if (coins < 100) {
      return "Bronze";
    } else if (coins < 500) {
      return "Silver";
    } else {
      return "Gold";
    }
  }

  int getAccountLevelColor() {
    var coins = user.value?.coins ?? 0;
    if (coins < 500) {
      // Golden Rod for bronze text
      return 0xFFDAA520;
    } else if (coins < 1000) {
      // Silver Sand for silver text
      return 0xFFBFC1C2;
    } else {
      // Luminous Gold for gold text
      return 0xFFFFD700;
    }
  }

  String getAccountLevelIcon() {
    var coins = user.value?.coins ?? 0;
    if (coins < 500) {
      return "🥉";
    } else if (coins < 1000) {
      return "🥈";
    } else {
      return "🥇";
    }
  }

  int getAccountLevelBackgroundColor() {
    var coins = user.value?.coins ?? 0;
    if (coins < 500) {
      // Saddle Brown for bronze background
      return 0xFF8B4513;
    } else if (coins < 1000) {
      // Dim Grey for silver background
      return 0xFF696969;
    } else {
      // Dark Goldenrod for gold background
      return 0xFF8B7500;
    }
  }

  void updateQuickStats() async {
    var projectController = Get.find<ProjectController>();
    try {
      await projectController.loadProjects();
      await projectController.loadMyActivities();
    } catch (e) {}
    var totalProjects = projectController.projects.length;
    var myActivities = projectController.myActivities.length;

    quickStats.value = [
      {
        "icon": "🚩",
        "name": "projects".tr,
        "count": totalProjects.toString(),
      },
      {
        "icon": "🟡",
        "name": "rewards".tr,
        "count": user.value?.coins.toString(),
      },
      {
        "icon": "🗒️",
        "name": "completed".tr,
        "count": myActivities.toString(),
      }
    ];

    update();
  }
}
