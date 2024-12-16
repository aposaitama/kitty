import 'package:flutter/material.dart';
import 'package:kitty/pages/settings_page/choose_language_page/provider/localization_cubit.dart';
import 'package:provider/provider.dart';

import 'package:easy_localization/easy_localization.dart';

class ChooseLanguagePage extends StatelessWidget {
  const ChooseLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = context.read<LocaleProvider>();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              localeProvider.changeLocale(const Locale('uk'));
              context.setLocale(const Locale('uk'));
              Navigator.pop(context);
            },
            child: const Text('Ukrainian'),
          ),
          GestureDetector(
            onTap: () {
              localeProvider.changeLocale(const Locale('en'));
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
