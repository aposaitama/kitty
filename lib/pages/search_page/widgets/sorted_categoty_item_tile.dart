import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kitty/models/expense/expense.dart';
import 'package:kitty/styles/colors.dart';

class SortedCategotyItemTile extends StatelessWidget {
  final Expense expense;
  const SortedCategotyItemTile({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1.0, color: AppColors.borderColor),
      ),
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
                          expense.categoryIcon,
                          height: 24.0,
                          width: 24.0,
                        )
                      ])),
              const SizedBox(
                width: 8.0,
              ),
              expense.description != ''
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          expense.description!,
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Inter',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          expense.category,
                          style: const TextStyle(
                              color: AppColors.header,
                              fontFamily: 'Inter',
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    )
                  : Text(
                      expense.category,
                      style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Inter',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400),
                    ),
            ],
          ),
          Text(
            expense.type == 'Expense' ? '- ${expense.amount}' : expense.amount,
            style: TextStyle(
                color: expense.type == 'Expense' ? Colors.red : Colors.black,
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
