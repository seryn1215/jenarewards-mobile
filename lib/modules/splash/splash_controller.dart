import 'package:capusle_rewards/routes/routes.dart';
import 'package:capusle_rewards/shared/shared.dart';
import 'package:capusle_rewards/shared/storage/storage_util.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  @override
  void onReady() async {
    super.onReady();
    await Future.delayed(Duration(milliseconds: 2000));
    var uid = StorageUtil.get("uid");
    print("object" + uid.toString());
    try {
      if (uid != null) {
        Get.toNamed(Routes.HOME);
      } else {
        Get.toNamed(Routes.AUTH);
      }
    } catch (e) {
      Get.toNamed(Routes.AUTH);
    }
  }
}
