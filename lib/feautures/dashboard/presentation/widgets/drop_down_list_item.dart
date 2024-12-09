import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kitty/feautures/dashboard/presentation/styles/colors.dart';

class DropDownListItem extends StatelessWidget {
  final String text;
  final List<String> items;

  const DropDownListItem({
    super.key,
    required this.text,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: text,
        contentPadding:
            const EdgeInsets.only(left: 24, top: 18, bottom: 18, right: 30),
        hintStyle: const TextStyle(
            fontFamily: 'Inter',
            color: AppColors.hintText,
            fontSize: 14,
            fontWeight: FontWeight.w400),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none),
        ),
      ),
      icon: SvgPicture.asset('assets/icons/keyboard-arrow-down.svg'),
      items: items
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ))
          .toList(),
      onChanged: (String? value) {},
    );
  }
}
