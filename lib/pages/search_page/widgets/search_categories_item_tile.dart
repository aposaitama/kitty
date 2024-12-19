import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kitty/styles/colors.dart';

class SearchCategoriesItemTile extends StatelessWidget {
  final String name;
  final String iconPath;
  const SearchCategoriesItemTile(
      {super.key, required this.name, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(width: 1.0, color: AppColors.categoryBorderColor)),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
            ),
            const SizedBox(
              width: 6.0,
            ),
            Text(
              name,
              style: const TextStyle(
                color: AppColors.introMainText,
                fontFamily: 'Inter',
                fontSize: 15.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
