import 'dart:io';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kitty/models/user/user.dart';
import 'package:kitty/pages/auth_pages/cubit/auth_cubit.dart';
import 'package:kitty/pages/settings_page/widgets/settings_list_item.dart';
import 'package:kitty/styles/colors.dart';

class SettingsPageScreen extends StatelessWidget {
  const SettingsPageScreen({super.key});

  Future<void> _pickProfileImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      print(
          'Image picked: ${pickedFile.path}'); // Лог для перевірки шляху вибраного файлу

      final user = context.read<AuthCubit>().getCurrentUser();

      if (user != null) {
        user.icon = pickedFile.path;

        print(
            'Updating user with new icon: ${pickedFile.path}'); // Лог перед оновленням
        context.read<AuthCubit>().updateUser(user);
      } else {
        print('No user found to update icon'); // Лог, якщо користувач відсутній
      }
    } else {
      print('No image picked'); // Лог, якщо користувач не вибрав зображення
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.greyHeaderColor,
          title: const Text(
            'Settings',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 20.0,
              letterSpacing: 0.18,
              fontWeight: FontWeight.w900,
              color: AppColors.header,
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              height: 100,
              color: AppColors.greyHeaderColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 28.0,
                    ),
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        final user = context.read<AuthCubit>().getCurrentUser();
                        print(
                            'Building user profile: ${user?.login}, icon: ${user?.icon}'); // Лог для перевірки даних користувача

                        return Row(
                          children: [
                            GestureDetector(
                              onTap: () => _pickProfileImage(context),
                              child: CircleAvatar(
                                radius: 24,
                                backgroundImage: user?.icon != null
                                    ? FileImage(File(user!.icon!))
                                    : null,
                                child: user?.icon == null
                                    ? const Icon(Icons.account_circle, size: 48)
                                    : null,
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user?.login ?? 'Unknown User',
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromARGB(255, 39, 39, 39),
                                  ),
                                ),
                                Text(
                                  user?.email ?? 'Unknown Email',
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.header,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => context.go('/manage_categories'),
                    child: SettingsListItem(
                      iconPath: 'assets/icons/categories.svg',
                      title: "manage_categories".tr(),
                    ),
                  ),
                  const SizedBox(
                    height: 26.0,
                  ),
                  SettingsListItem(
                    iconPath: 'assets/icons/export.svg',
                    title: "export_to_pdf".tr(),
                  ),
                  const SizedBox(
                    height: 26.0,
                  ),
                  SettingsListItem(
                    iconPath: 'assets/icons/currency.svg',
                    title: "choose_currency".tr(),
                  ),
                  const SizedBox(
                    height: 26.0,
                  ),
                  GestureDetector(
                    onTap: () => context.go('/settings/choose_language'),
                    child: SettingsListItem(
                      iconPath: 'assets/icons/translate.svg',
                      title: "choose_language".tr(),
                    ),
                  ),
                  const SizedBox(
                    height: 26.0,
                  ),
                  SettingsListItem(
                    iconPath: 'assets/icons/faq.svg',
                    title: "faq".tr(),
                  ),
                  const SizedBox(
                    height: 26.0,
                  ),
                  GestureDetector(
                    onTap: () => {
                      context.read<AuthCubit>().logout(),
                      context.go('/login')
                    },
                    child: SettingsListItem(
                      iconPath: 'assets/icons/logout.svg',
                      title: "logout".tr(),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
