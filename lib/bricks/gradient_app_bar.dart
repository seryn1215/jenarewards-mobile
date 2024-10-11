import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../shared/constants/colors.dart';

// - - - - - - - - - - - - Instructions - - - - - - - - - - - - - -
// Place AppBarFb1 inside the app bar property of a Scaffold
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

class GradientAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final bool showBackButton;
  final String? title;

  GradientAppBar({Key? key, this.showBackButton = true, this.title})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    const primaryColor = ColorConstants.primaryColor;
    const secondaryColor = ColorConstants.secondaryColor;
    const accentColor = Color(0xffffffff);
    const backgroundColor = Color(0xffffffff);
    const errorColor = Color(0xffEF4444);

    return AppBar(
      title: Text(title ?? "title".tr, style: TextStyle(color: Colors.white)),
      backgroundColor: primaryColor,
      automaticallyImplyLeading: showBackButton,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor, secondaryColor],
            stops: [0.5, 1.0],
          ),
        ),
      ),
    );
  }
}
