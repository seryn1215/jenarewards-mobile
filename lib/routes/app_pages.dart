import 'package:get/get.dart';

import '../app/modules/privacy_policy/bindings/privacy_policy_binding.dart';
import '../app/modules/privacy_policy/views/privacy_policy_view.dart';
import '../modules/auth/auth.dart';
import '../modules/home/home.dart';
import '../modules/me/cards/cards_screen.dart';
import '../modules/modules.dart';
import '../modules/project/add_project_screen.dart';
import '../modules/project/project_detail_screen.dart';
import '../modules/project/project_qr_scanner.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.AUTH,
      page: () => AuthScreen(),
      binding: AuthBinding(),
      children: [
        GetPage(name: Routes.REGISTER, page: () => RegisterScreen()),
        GetPage(name: Routes.LOGIN, page: () => LoginScreen()),
      ],
    ),
    GetPage(
        name: Routes.HOME,
        page: () => HomeScreen(),
        binding: HomeBinding(),
        children: [
          GetPage(name: Routes.CARDS, page: () => CardsScreen()),
          GetPage(name: Routes.ADD_PROJECT, page: () => AddProjectScreen()),
          GetPage(name: Routes.PROJECT_DETAIL, page: () => ProjectDetailPage()),
          GetPage(name: Routes.JOIN_PROJECT, page: () => ProjectQrScanner()),
        ]),
    GetPage(
      name: Routes.PRIVACY_POLICY,
      page: () => const PrivacyPolicyView(),
      binding: PrivacyPolicyBinding(),
    ),
  ];
}
