import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kitty/pages/auth_pages/cubit/auth_cubit.dart';

class PasswordInputPage extends StatelessWidget {
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final login =
                    'Alex'; // Отримати логін з контексту або зі збережених даних
                context
                    .read<AuthCubit>()
                    .submitPassword(login, passwordController.text);
              },
              child: Text('Submit'),
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
