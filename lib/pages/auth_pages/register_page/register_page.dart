import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kitty/pages/auth_pages/cubit/auth_cubit.dart';
import 'package:kitty/styles/colors.dart';
import 'package:kitty/widgets/blue_bottom_button.dart';
import 'package:kitty/widgets/custom_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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
            CustomTextField(
              labelText: 'Confirm password',
              controller: confirmPasswordController,
            ),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => context.go('/login'),
                  child: const Text(
                    'Already have an account? Sign IN',
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
            GestureDetector(
              onTap: () => {
                context.read<AuthCubit>().register(
                      loginController.text,
                      passwordController.text,
                      confirmPasswordController.text,
                    )
              },
              child: const BlueBottomButton(
                buttonTitle: 'Register',
              ),
            ),
            BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state == AuthState.authenticated) {
                  context.go('/home');
                } else if (state == AuthState.error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Error during registration!')),
                  );
                }
              },
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
