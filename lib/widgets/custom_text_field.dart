import 'package:flutter/material.dart';
import 'package:kitty/styles/colors.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  const CustomTextField({super.key, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: false,
      style: const TextStyle(
          color: Colors.black,
          fontFamily: 'Inter',
          fontSize: 16.0,
          fontWeight: FontWeight.w400),
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
            color: AppColors.hintText,
          ),
          floatingLabelStyle: const TextStyle(
            color: AppColors.blueStackButton,
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.blueStackButton,
              width: 2.0,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.hintText,
              width: 1.0,
            ),
          )),
    );
  }
}
