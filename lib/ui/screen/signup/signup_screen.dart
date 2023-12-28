import 'package:ambataapp/authentication/validator.dart';
import 'package:ambataapp/ui/screen/signup/cubit/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../component/root.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  final GlobalKey<ScaffoldMessengerState> snackbarKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final state = context.watch<SignUpCubit>().state;

    if (state.errorMessage != null) {
      final SnackBar snackBar = SnackBar(
        content: Text(
          state.errorMessage!,
          style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSecondary),
        ),
        duration: const Duration(seconds: 2),
      );
      widget.snackbarKey.currentState?.showSnackBar(snackBar);
      context.read<SignUpCubit>().errorMessageShowed();
    }

    return ScaffoldMessenger(
      key: widget.snackbarKey,
      child: AmbataScaffold(
        resizeToAvoidBottomInset: true,
        child: Padding(
          padding: const EdgeInsets.only(left: 32.0, top: 16.0, right: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign Up',
                style: textTheme.headlineLarge,
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                onChanged: (value) =>
                    context.read<SignUpCubit>().emailChanged(value),
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Email',
                  helperText: 'Your account email',
                  errorText: Validator.isValidEmail(state.email)
                      ? null
                      : 'Not valid email',
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              TextField(
                onChanged: (value) =>
                    context.read<SignUpCubit>().passwordChanged(value),
                obscureText: true,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Password',
                  helperText:
                      'Your password must be at least 8 characters consists of letters and numbers!',
                  helperMaxLines: 3,
                  errorText: Validator.isValidPassword(state.password)
                      ? null
                      : 'Not valid password',
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              TextField(
                onChanged: (value) =>
                    context.read<SignUpCubit>().confirmedPasswordChanged(value),
                obscureText: true,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Confirm Password',
                  helperText: 'Confirm your password',
                  errorText: (state.password == state.confirmedPassword)
                      ? null
                      : 'Not valid password',
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              FilledButton(
                onPressed: () {
                  context.read<SignUpCubit>().signUp();
                },
                style: FilledButton.styleFrom(
                  backgroundColor: colorScheme.secondary,
                  minimumSize: const Size(double.infinity, 40),
                ),
                child: Text(
                  'Sign Up',
                  style: textTheme.labelLarge
                      ?.copyWith(color: colorScheme.onSecondary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
