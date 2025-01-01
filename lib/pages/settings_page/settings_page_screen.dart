import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:image_picker/image_picker.dart';

import 'package:kitty/pages/auth_pages/cubit/auth_cubit.dart';
import 'package:kitty/pages/settings_page/widgets/settings_list_item.dart';
import 'package:kitty/styles/colors.dart';

class SettingsPageScreen extends StatefulWidget {
  const SettingsPageScreen({super.key});

  @override
  State<SettingsPageScreen> createState() => _SettingsPageScreenState();
}

// String? temporaryIconPath;

class _SettingsPageScreenState extends State<SettingsPageScreen> {
  Future<void> _pickProfileImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // setState(() {
      //   temporaryIconPath = pickedFile.path;
      // });
      final user = context.read<AuthCubit>().getCurrentUser();
      if (user != null) {
        user.icon = pickedFile.path;

        context.read<AuthCubit>().updateUser(user);
      }
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
                        final fileExists = user?.icon != null &&
                            File(user!.icon!).existsSync();
                        return Row(
                          children: [
                            GestureDetector(
                              onTap: () => _pickProfileImage(context),
                              child: CircleAvatar(
                                radius: 24,
                                backgroundImage: fileExists
                                    ? FileImage(File(user.icon!))
                                    : null,
                                child: !fileExists
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
                  GestureDetector(
                    onTap: () => context.go('/settings/full_report'),
                    child: SettingsListItem(
                      iconPath: 'assets/icons/export.svg',
                      title: "export_to_pdf".tr(),
                    ),
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
                  const SizedBox(
                    height: 26.0,
                  ),
                  GestureDetector(
                    onTap: () => {
                      context.read<AuthCubit>().deleteUser(),
                      context.go('/login')
                    },
                    child: const SettingsListItem(
                      iconPath: 'assets/icons/logout.svg',
                      title: "Delete User",
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
