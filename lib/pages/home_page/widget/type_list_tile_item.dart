import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kitty/models/categories/categories.dart';
import 'package:kitty/pages/home_page/cubit/categoryID_cubit.dart';
import 'package:kitty/styles/colors.dart';

class TypeListTileItem extends StatefulWidget {
  final int iconID;
  final String type;
  final String description;
  final String name;
  final String amount;

  const TypeListTileItem({
    super.key,
    required this.type,
    required this.amount,
    required this.name,
    required this.iconID,
    required this.description,
  });

  @override
  State<TypeListTileItem> createState() => _TypeListTileItemState();
}

class _TypeListTileItemState extends State<TypeListTileItem> {
  @override
  void initState() {
    super.initState();
    // Завантажуємо категорію для цього iconID
    context.read<CategoryIDCubit>().loadCategory(widget.iconID);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryIDCubit, Map<int, Categories?>>(
      buildWhen: (previous, current) =>
          previous[widget.iconID] != current[widget.iconID],
      builder: (context, state) {
        final category = state[widget.iconID];

        if (category == null) {
          return const CircularProgressIndicator(); // Дані завантажуються
        }

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
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(category.background_color),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        category.icon,
                        height: 24.0,
                        width: 24.0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  widget.description.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.description,
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              widget.name,
                              style: const TextStyle(
                                color: AppColors.header,
                                fontFamily: 'Inter',
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          widget.name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Inter',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                ],
              ),
              Text(
                widget.type == 'Expense' ? '- ${widget.amount}' : widget.amount,
                style: TextStyle(
                  color: widget.type == 'Expense' ? Colors.red : Colors.black,
                  fontFamily: 'Inter',
                  fontSize: 14.0,
                  height: 1.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
