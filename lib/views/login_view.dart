import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/service/auth/auth_exceptions.dart';
import 'package:mynotes/service/auth/auth_service.dart';

import '../utilities/dialogs/error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Login")),
        body: Column(
          children: [
            TextField(
              controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "Enter Your Email Here.",
              ),
            ),
            TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                hintText: "Enter Your Password Here.",
              ),
            ),
            TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;

                try {
                  final userCredential = await AuthService.firebase()
                      .login(email: email, password: password);
                  final user = AuthService.firebase().currentUser;
                  if (user?.isEmailVerified ?? false) {
                    if (context.mounted) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          notesRoute, (route) => false);
                    }
                  } else {
                    if (context.mounted) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          verifyEmailRoute, (route) => false);
                    }
                  }

                  devtools.log(userCredential.toString());
                } on UserNotFoundAuthException {
                  if (context.mounted) {
                    await showErrorDialog(
                      context,
                      "user-not-found",
                    );
                  }
                } on WrongPasswordAuthException {
                  if (context.mounted) {
                    await showErrorDialog(
                      context,
                      "wrong-password",
                    );
                  }
                } on GenericAuthException {
                  if (context.mounted) {
                    await showErrorDialog(
                      context,
                      'Auth Error',
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    await showErrorDialog(
                      context,
                      'Error: ${e.toString()}',
                    );
                  }
                }
              },
              child: const Text("Login"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  registerRoute,
                  (route) => false,
                );
              },
              child: const Text('Not Reistered? Reister now'),
            ),
          ],
        ));
  }
}
