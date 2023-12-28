import 'package:ambataapp/ui/component/root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../authentication/validator.dart';
import 'cubit/signin_cubit.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldMessengerState> snackbarKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final state = context.watch<SignInCubit>().state;

    if (state.errorMessage != null) {
      final SnackBar snackBar = SnackBar(
        content: Text(
          state.errorMessage!,
          style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSecondary),
        ),
        duration: const Duration(seconds: 2),
      );
      widget.snackbarKey.currentState?.showSnackBar(snackBar);
      context.read<SignInCubit>().errorMessageShowed();
    }

    return ScaffoldMessenger(
      key: widget.snackbarKey,
      child: AmbataScaffold(
        resizeToAvoidBottomInset: true,
        child: Padding(
          padding: const EdgeInsets.only(left: 32.0, top: 16.0, right: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/img/cover_login.png',
                width: 240,
                height: 240,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sign In',
                    style: textTheme.headlineLarge,
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  TextField(
                    onChanged: (value) =>
                        context.read<SignInCubit>().emailChanged(value),
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
                        context.read<SignInCubit>().passwordChanged(value),
                    obscureText: true,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Password',
                      helperText: 'Your password',
                      errorText: Validator.isValidPassword(state.password)
                          ? null
                          : 'Not valid password',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 48.0,
              ),
              FilledButton(
                onPressed: () {
                  context.read<SignInCubit>().signInWithEmailAndPassword();
                },
                style: FilledButton.styleFrom(
                  backgroundColor: colorScheme.secondary,
                  minimumSize: const Size(double.infinity, 40),
                ),
                child: Text(
                  'Sign In',
                  style: textTheme.labelLarge
                      ?.copyWith(color: colorScheme.onSecondary),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              FilledButton(
                onPressed: () {
                  context.read<SignInCubit>().signInWithGoogle();
                },
                style: FilledButton.styleFrom(
                  backgroundColor: colorScheme.secondary,
                  minimumSize: const Size(double.infinity, 40),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/google.svg',
                      width: 24.0,
                      height: 24.0,
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      'Sign In With Google',
                      style: textTheme.labelLarge
                          ?.copyWith(color: colorScheme.onSecondary),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Divider(),
              const SizedBox(
                height: 16.0,
              ),
              InkWell(
                onTap: () {
                  GoRouter.of(context).goNamed('sign_up');
                },
                child: Text(
                  "Don't have an account? Sign Up!",
                  style: TextStyle(
                    color: colorScheme.secondary,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
