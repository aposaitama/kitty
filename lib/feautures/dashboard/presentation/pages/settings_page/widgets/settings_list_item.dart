import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsListItem extends StatelessWidget {
  final String iconPath;
  final String title;

  const SettingsListItem(
      {super.key, required this.iconPath, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(iconPath),
            const SizedBox(
              width: 8.0,
            ),
            Text(
              title,
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Inter',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400),
            )
          ],
        ),
        SvgPicture.asset('assets/icons/arrow_right.svg')
      ],
    );
  }
}
