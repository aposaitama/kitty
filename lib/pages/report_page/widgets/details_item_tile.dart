import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kitty/models/categories/categories.dart';
import 'package:kitty/pages/home_page/cubit/categoryID_cubit.dart';
import 'package:kitty/styles/colors.dart';

class DetailsItemTile extends StatefulWidget {
  final String categoryName;
  final String iconPath;
  final String transactionCount;
  final double totalSum;
  final double percent;
  final int backgroundColor;
  final int categoryID;
  const DetailsItemTile(
      {super.key,
      required this.iconPath,
      required this.transactionCount,
      required this.totalSum,
      required this.percent,
      required this.categoryName,
      required this.backgroundColor,
      required this.categoryID});

  @override
  State<DetailsItemTile> createState() => _DetailsItemTileState();
}

class _DetailsItemTileState extends State<DetailsItemTile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<CategoryIDCubit>().loadCategory(widget.categoryID);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryIDCubit, Map<int, Categories?>>(
      builder: (context, state) {
        // final category = state[widget.categoryID];
        // print(category!.background_color);
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
                        decoration: BoxDecoration(
                          color: Color(widget.backgroundColor),
                          shape: BoxShape.circle,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(widget.iconPath),
                          ],
                        )),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.categoryName,
                          style: const TextStyle(
                            color: AppColors.introMainText,
                            fontFamily: 'Inter',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${widget.transactionCount} transactions',
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
                      widget.totalSum.toStringAsFixed(0),
                      style: TextStyle(
                        color:
                            widget.totalSum > 0 ? AppColors.header : Colors.red,
                        fontFamily: 'Inter',
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${widget.percent.toStringAsFixed(0)}%',
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
      },
    );
  }
}
