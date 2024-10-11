import 'package:capusle_rewards/modules/auth/auth.dart';
import 'package:capusle_rewards/modules/db/database_controller.dart';
import 'package:capusle_rewards/modules/project/project_controller.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<DatabaseController>(() => DatabaseController());
    Get.lazyPut<ProjectController>(() => ProjectController());
    Get.lazyPut<HomeController>(
        () => HomeController(apiRepository: Get.find()));
  }
}
