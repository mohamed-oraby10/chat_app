import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MainButton extends StatelessWidget {
  MainButton({super.key, required this.buttonText, required this.onPress});
  VoidCallback? onPress;
  String? buttonText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress!,
      child: Text(
        buttonText!,
        style: TextStyle(fontSize: 18, color: kMainColor),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 45),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}
