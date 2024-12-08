import 'package:flutter/material.dart';
import 'package:kitty/feautures/dashboard/presentation/pages/settings_page/widgets/settings_list_item.dart';
import 'package:kitty/feautures/dashboard/presentation/styles/colors.dart';

class SettingsPageScreen extends StatelessWidget {
  const SettingsPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: 168,
          color: AppColors.greyHeaderColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 32.0,
                ),
                const Row(
                  children: [
                    Text(
                      'Settings',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 20.0,
                          fontWeight: FontWeight.w900,
                          color: AppColors.header),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 28.0,
                ),
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'John Doe',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 39, 39, 39)),
                        ),
                        Text(
                          'john.doe@gmail.com',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                              color: AppColors.header),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SettingsListItem(
                iconPath: 'assets/icons/categories.svg',
                title: 'Manage categories',
              ),
              SizedBox(
                height: 26.0,
              ),
              SettingsListItem(
                iconPath: 'assets/icons/export.svg',
                title: 'Export to PDF',
              ),
              SizedBox(
                height: 26.0,
              ),
              SettingsListItem(
                iconPath: 'assets/icons/currency.svg',
                title: 'Choose currency',
              ),
              SizedBox(
                height: 26.0,
              ),
              SettingsListItem(
                iconPath: 'assets/icons/translate.svg',
                title: 'Choose language',
              ),
              SizedBox(
                height: 26.0,
              ),
              SettingsListItem(
                iconPath: 'assets/icons/faq.svg',
                title: 'Frequently asked questions',
              ),
              SizedBox(
                height: 26.0,
              ),
              SettingsListItem(
                iconPath: 'assets/icons/logout.svg',
                title: 'Logout',
              ),
            ],
          ),
        )
      ],
    ));
  }
}
