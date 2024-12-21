import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kitty/styles/colors.dart';

class DetailsItemTile extends StatelessWidget {
  final String categoryName;
  final String iconPath;
  final String transactionCount;
  final double totalSum;
  final double percent;
  const DetailsItemTile(
      {super.key,
      required this.iconPath,
      required this.transactionCount,
      required this.totalSum,
      required this.percent,
      required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: const BoxDecoration(
                        color: Colors.amber, shape: BoxShape.circle),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(iconPath),
                      ],
                    )),
                const SizedBox(
                  width: 8.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      categoryName,
                      style: const TextStyle(
                        color: AppColors.introMainText,
                        fontFamily: 'Inter',
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '$transactionCount transactions',
                      style: const TextStyle(
                        color: AppColors.header,
                        fontFamily: 'Inter',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  totalSum.toStringAsFixed(0),
                  style: TextStyle(
                    color: totalSum > 0 ? AppColors.header : Colors.red,
                    fontFamily: 'Inter',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${percent.toStringAsFixed(0)}%',
                  style: const TextStyle(
                    color: AppColors.introMainText,
                    fontFamily: 'Inter',
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            )
          ],
        ),
        const SizedBox(
          height: 16.0,
        ),
      ],
    );
  }
}
