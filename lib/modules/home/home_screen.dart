import 'package:capusle_rewards/bricks/gradient_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:capusle_rewards/modules/home/home.dart';
import 'package:capusle_rewards/shared/shared.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    return WillPopScope(
      onWillPop: () async => false,
      child: Obx(() => _buildWidget()),
    );
  }

  Widget _buildWidget() {
    return Scaffold(
      body: Center(
        child: _buildContent(controller.currentTab.value),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedLabelStyle: const TextStyle(color: Color(0xFFC6CEDD)),
        items: [
          _buildNavigationBarItem("home".tr, Icons.home,
              MainTabs.home == controller.currentTab.value),
          _buildNavigationBarItem("projects".tr, Icons.list_alt_rounded,
              MainTabs.discover == controller.currentTab.value),
          // _buildNavigationBarItem("shop".tr, Icons.shop,
          //     MainTabs.resource == controller.currentTab.value),
          _buildNavigationBarItem("notifications".tr, Icons.notifications,
              MainTabs.inbox == controller.currentTab.value),
          _buildNavigationBarItem("profile".tr, Icons.settings,
              MainTabs.me == controller.currentTab.value)
        ],
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: ColorConstants.black,
        currentIndex: controller.getCurrentIndex(controller.currentTab.value),
        selectedItemColor: ColorConstants.primaryColorDark,
        selectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        onTap: (index) => controller.switchTab(index),
      ),
    );
  }

  Widget _buildContent(MainTabs tab) {
    switch (tab) {
      case MainTabs.home:
        return controller.mainTab;
      case MainTabs.discover:
        return controller.discoverTab;
      case MainTabs.resource:
        return controller.resourceTab;
      case MainTabs.inbox:
        return controller.inboxTab;
      case MainTabs.me:
        return controller.meTab;
      default:
        return controller.mainTab;
    }
  }

  BottomNavigationBarItem _buildNavigationBarItem(
      String label, IconData icon, bool isActivited) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color:
            isActivited ? ColorConstants.primaryColorDark : Color(0xFFC6CEDD),
      ),
      label: label,
    );
  }
}
