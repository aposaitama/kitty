import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kitty/styles/colors.dart';

class TypeListTileItem extends StatelessWidget {
  // final int backgroundColor;
  final String type;
  final String categoryIcon;
  final String name;
  final String description;
  final String amount;
  const TypeListTileItem({
    super.key,
    required this.type,
    required this.description,
    required this.amount,
    required this.name,
    required this.categoryIcon,
  });
  // required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          categoryIcon,
                          height: 24.0,
                          width: 24.0,
                        )
                      ])),
              const SizedBox(
                width: 8.0,
              ),
              description.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          description,
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Inter',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          name,
                          style: const TextStyle(
                              color: AppColors.header,
                              fontFamily: 'Inter',
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    )
                  : Text(
                      name,
                      style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Inter',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400),
                    ),
            ],
          ),
          Text(
            type == 'Expense' ? '- $amount' : amount,
            style: TextStyle(
                color: type == 'Expense' ? Colors.red : Colors.black,
                fontFamily: 'Inter',
                fontSize: 14.0,
                height: 1.0,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
