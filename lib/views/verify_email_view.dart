import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/service/auth/auth_service.dart';
import 'package:mynotes/service/auth/bloc/auth_bloc.dart';
import 'package:mynotes/service/auth/bloc/auth_event.dart';
import 'package:mynotes/service/auth/bloc/auth_state.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text(
              "We've sent you an email verification. Please open it and verify you account"),
          const Text(
              "If you haven't received a verification email yet, press the button below"),
          TextButton(
            onPressed: () async {
              context
                  .read<AuthBloc>()
                  .add(const AuthEventSendEmailVerification());
            },
            child: const Text("Send email verification"),
          ),
          TextButton(
              onPressed: () async {
                context.read<AuthBloc>().add(const AuthEventLogOut());
              },
              child: const Text("Register"))
        ],
      ),
    );
  }
}
