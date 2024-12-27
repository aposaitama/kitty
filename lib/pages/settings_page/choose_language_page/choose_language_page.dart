import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';

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
              context.go('/home');
              context.setLocale(const Locale('uk'));
            },
            child: const Text('Ukrainian'),
          ),
          GestureDetector(
            onTap: () {
              context.go('/home');
              context.setLocale(const Locale('en'));
            },
            child: const Text('English'),
          ),
        ],
      ),
    );
  }
}
