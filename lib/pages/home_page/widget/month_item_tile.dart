import 'package:flutter/material.dart';
import 'package:kitty/styles/colors.dart';

class MonthItemTile extends StatefulWidget {
  final String month;
  final bool isSelected;
  const MonthItemTile({
    super.key,
    required this.month,
    required this.isSelected,
  });

  @override
  State<MonthItemTile> createState() => _MonthItemTileState();
}

class _MonthItemTileState extends State<MonthItemTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget.isSelected ? AppColors.blueStackButton : Colors.white,
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
              width: 1.0,
              color: widget.isSelected
                  ? AppColors.blueStackButton
                  : AppColors.borderColor)),
      child: Center(
          child: Text(
        widget.month,
        style: TextStyle(
            color: widget.isSelected ? Colors.white : Colors.black,
            fontFamily: 'Inter',
            fontSize: 14.0,
            fontWeight: FontWeight.w600),
      )),
    );
  }
}
