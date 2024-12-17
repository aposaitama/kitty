import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kitty/styles/colors.dart';

class CategoriesItemListTile extends StatelessWidget {
  final String iconPath;
  final String categoryName;

  const CategoriesItemListTile(
      {super.key, required this.iconPath, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(iconPath),
              const SizedBox(
                width: 8.0,
              ),
              Text(categoryName)
            ],
          ),
          Row(
            children: [
              const Text(
                'Edit',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: AppColors.blueStackButton,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                width: 16.0,
              ),
              SvgPicture.asset('assets/icons/sixDots.svg')
            ],
          )
        ],
      ),
    );
  }
}
