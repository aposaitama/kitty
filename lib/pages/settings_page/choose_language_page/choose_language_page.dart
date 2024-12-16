import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';

class ChooseLanguagePage extends StatelessWidget {
  const ChooseLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              context.setLocale(const Locale('uk'));
              Navigator.pop(context);
            },
            child: const Text('Ukrainian'),
          ),
          GestureDetector(
            onTap: () {
              context.setLocale(const Locale('en'));

              Navigator.pop(context);
            },
            child: const Text('English'),
          ),
        ],
      ),
    );
  }
}
