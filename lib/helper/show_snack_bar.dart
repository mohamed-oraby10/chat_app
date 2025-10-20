import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: kMainColor, fontSize: 16),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }


