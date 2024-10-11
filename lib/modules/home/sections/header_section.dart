import 'package:cached_network_image/cached_network_image.dart';
import 'package:capusle_rewards/bricks/info_card.dart';
import 'package:capusle_rewards/bricks/square_card.dart';
import 'package:capusle_rewards/shared/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import '../home_controller.dart';

class HeaderSection extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return Container(
      margin: EdgeInsets.only(bottom: 80),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 100, top: 16),
            color: Colors.pink,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 60),
                Obx(() => CircleAvatar(
                      radius: 50,
                      backgroundImage: CachedNetworkImageProvider(
                          controller.user.value?.photoUrl ?? ""),
                    )),
                SizedBox(height: 20),
                Obx(() => Text(
                      controller.user.value?.name ?? "",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )),
                Obx(
                  () => Text(
                    controller.user.value?.email ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          Obx(
            () => Positioned(
              top: 280,
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SquareCard(
                        text: "Earned",
                        icon: FontAwesomeIcons.coins,
                        iconColor: Colors.amber,
                        subtitle: "${controller.user.value?.coins ?? 0}",
                        onPressed: () {}),
                    CommonWidget.rowWidth(),
                    SquareCard(
                        text: "Redeemed",
                        icon: FontAwesomeIcons.wallet,
                        iconColor: Colors.green,
                        subtitle:
                            "${controller.user.value?.redeemedCoins ?? 0}",
                        onPressed: () {}),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
