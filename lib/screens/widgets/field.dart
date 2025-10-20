import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Field extends StatelessWidget {
  Field({this.hintName, this.onChanged,this.obscureText=false});
  String? hintName;
  Function(String)? onChanged;
  bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        obscureText: obscureText!,
        validator: (data) {
          if (data!.isEmpty) {
            return "field is required";
          }
        },
        style: TextStyle(color: Colors.white),
        onChanged: onChanged,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: hintName!,
          hintStyle: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
