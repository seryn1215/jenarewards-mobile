import 'package:capusle_rewards/shared/constants/colors.dart';
import 'package:flutter/material.dart';

class FancyButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const FancyButton({required this.text, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: AspectRatio(
        aspectRatio: 208 / 71,
        child: Container(
          child: MaterialButton(
            onPressed: onPressed,
            splashColor: Colors.lightBlue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
            padding: const EdgeInsets.all(0.0),
            child: Ink(
                decoration: BoxDecoration(
                  //gradient:
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/finance_app_2%2FbuttonBackgroundSmall.png?alt=media&token=fa2f9bba-120a-4a94-8bc2-f3adc2b58a73"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(36),
                ),
                child: Container(
                    constraints: const BoxConstraints(
                        minWidth: 88.0,
                        minHeight: 36.0), // min sizes for Material buttons
                    alignment: Alignment.center,
                    child: Text(text,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300)))),
          ),
        ),
      ),
    );
  }
}
