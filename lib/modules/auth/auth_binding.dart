import 'package:capusle_rewards/modules/db/database_controller.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<DatabaseController>(() => DatabaseController());
  }
}
