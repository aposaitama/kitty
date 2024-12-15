import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kitty/styles/colors.dart';
import 'package:path/path.dart';

class TypeListTileItem extends StatelessWidget {
  final String type;
  final String categoryIcon;
  final String name;
  final String description;
  final String amount;
  const TypeListTileItem(
      {super.key,
      required this.type,
      required this.description,
      required this.amount,
      required this.name,
      required this.categoryIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                categoryIcon,
              ),
              const SizedBox(
                width: 8.0,
              ),
              description != ''
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
