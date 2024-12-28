import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kitty/pages/auth_pages/cubit/auth_cubit.dart';
import 'package:kitty/pages/auth_pages/password_page/password_page.dart';
import 'package:kitty/route/cubit/navigation_cubit.dart';

import 'package:kitty/styles/colors.dart';
import 'package:kitty/widgets/blue_bottom_button.dart';
import 'package:kitty/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 34.0,
            ),
            Center(child: SvgPicture.asset('assets/icons/Logo.svg')),
            const SizedBox(
              height: 24.0,
            ),
            const Text(
              'Kitty',
              style: TextStyle(
                  color: AppColors.introMainText,
                  fontFamily: 'Inter',
                  fontSize: 24.0,
                  height: 1.0,
                  letterSpacing: 0.18,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              'Your expense manager',
              style: TextStyle(
                  color: AppColors.header,
                  fontFamily: 'Inter',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 70.0,
            ),
            CustomTextField(
              labelText: 'Enter login',
              controller: loginController,
            ),
            const SizedBox(
              height: 16.0,
            ),
            CustomTextField(
              labelText: 'Enter password',
              controller: passwordController,
            ),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => context.go('/register'),
                  child: const Text(
                    'Don\'t have an account yet? Sign UP',
                    style: TextStyle(
                        color: AppColors.header,
                        fontFamily: 'Inter',
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 32.0,
            ),
            BlocBuilder<NavigationCubit, String>(
              builder: (context, state) {
                return GestureDetector(
                    onTap: () {
                      // context.read<NavigationCubit>().updateRoute('/home');
                      // GoRouter.of(context).go('/home');

                      context.read<AuthCubit>().login(
                            loginController.text,
                            passwordController.text,
                          );
                    },
                    child: const BlueBottomButton(buttonTitle: 'Login'));
              },
            ),
            BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state == AuthState.authenticated) {
                  final user = context.read<AuthCubit>().getCurrentUser();
                  if (user != null) {
                    print(
                        'User authenticated: ${user.login}, icon: ${user.icon}');
                  }
                  context.go('/home');
                } else if (state == AuthState.unauthenticated) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Invalid login or password!')),
                  );
                } else if (state == AuthState.passwordRequired) {
                  context.go('/password');
                }
              },
              child: Container(),
            )
          ],
        ),
      ),
    );
  }
}
