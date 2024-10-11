import 'package:flutter/material.dart';
import 'package:capusle_rewards/shared/shared.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/green_logo.png"),
        ],
      ),
    );
  }
}
