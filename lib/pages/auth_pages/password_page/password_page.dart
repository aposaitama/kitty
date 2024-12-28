import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kitty/pages/auth_pages/cubit/auth_cubit.dart';
import 'package:kitty/styles/colors.dart';
import 'package:kitty/widgets/blue_bottom_button.dart';
import 'package:kitty/widgets/custom_text_field.dart';

class PasswordInputPage extends StatelessWidget {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Welcome Back',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 20.0,
              letterSpacing: 0.18,
              fontWeight: FontWeight.w900,
              color: AppColors.header,
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(child: SvgPicture.asset('assets/icons/Logo.svg')),
            const SizedBox(
              height: 16.0,
            ),
            Center(
              child: const Text(
                'Use biometrics to login',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20.0,
                  letterSpacing: 0.18,
                  fontWeight: FontWeight.w900,
                  color: AppColors.header,
                ),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            GestureDetector(
              onTap: () {
                context.read<AuthCubit>().biometricAuth();
              },
              child: Center(
                  child: SvgPicture.asset(
                'assets/icons/faceid.svg',
                height: 50,
                width: 50,
              )),
            ),
            const SizedBox(
              height: 32.0,
            ),
            Center(
              child: const Text(
                'Or enter login and password',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20.0,
                  letterSpacing: 0.18,
                  fontWeight: FontWeight.w900,
                  color: AppColors.header,
                ),
              ),
            ),
            const SizedBox(
              height: 16.0,
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
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: () {
                context.read<AuthCubit>().submitPassword(
                    loginController.text, passwordController.text);
              },
              child: BlueBottomButton(buttonTitle: 'Submit'),
            ),
            BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state == AuthState.authenticated) {
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
