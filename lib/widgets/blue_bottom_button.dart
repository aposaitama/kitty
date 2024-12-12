import 'package:flutter/material.dart';
import 'package:kitty/styles/colors.dart';

class BlueBottomButton extends StatelessWidget {
  final String buttonTitle;
  const BlueBottomButton({super.key, required this.buttonTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      decoration: BoxDecoration(
        color: AppColors.blueStackButton,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            buttonTitle,
            style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
