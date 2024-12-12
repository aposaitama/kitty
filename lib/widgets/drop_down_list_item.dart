import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kitty/styles/colors.dart';

class DropDownListItem extends StatefulWidget {
  final String text;
  final List<String> items;
  final Function(String?)? onChanged;

  const DropDownListItem({
    super.key,
    required this.text,
    required this.items,
    this.onChanged,
  });

  @override
  State<DropDownListItem> createState() => _DropDownListItemState();
}

class _DropDownListItemState extends State<DropDownListItem> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();

    selectedValue = widget.items[0];
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      style: const TextStyle(
          color: Colors.black,
          fontFamily: 'Inter',
          fontSize: 16.0,
          fontWeight: FontWeight.w400),
      hint: Align(
        alignment: Alignment.center,
        child: Text(
          widget.text,
          style: const TextStyle(
              fontFamily: 'Inter',
              color: AppColors.hintText,
              fontSize: 16.0,
              fontWeight: FontWeight.w400),
        ),
      ),
      decoration: InputDecoration(
        floatingLabelStyle: const TextStyle(
          color: AppColors.blueStackButton,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.blueStackButton,
            width: 2.0,
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(width: 1, style: BorderStyle.solid),
        ),
      ),
      icon: SvgPicture.asset('assets/icons/keyboard-arrow-down.svg'),
      items: widget.items
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ))
          .toList(),
      onChanged: (String? value) {
        setState(() {
          selectedValue = value;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
    );
  }
}
