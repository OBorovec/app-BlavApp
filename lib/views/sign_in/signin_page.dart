import 'dart:io';

import 'package:blavapp/bloc/profile/user_signin/user_sign_in_bloc.dart';
import 'package:blavapp/components/control/text_field.dart';
import 'package:blavapp/components/pages/page_plain.dart';
import 'package:blavapp/components/views/title_divider.dart';
import 'package:blavapp/route_generator.dart';
import 'package:blavapp/services/auth_repo.dart';
import 'package:blavapp/utils/toasting.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserSignInBloc(
        authRepo: context.read<AuthRepo>(),
      ),
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: PlainPage(
          titleText: AppLocalizations.of(context)!.contSignInTitle,
          body: BlocListener<UserSignInBloc, UserSignInState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: userSignInListener,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: const [
                      _EmailTextField(),
                      SizedBox(height: 16),
                      _PasswordTextField(),
                      SizedBox(height: 4),
                      _ForgottenPasswordButton(),
                      SizedBox(height: 16),
                      _SignInButton(),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 16),
                      TitleDivider(
                        title: AppLocalizations.of(context)!.genOr,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      const SizedBox(height: 16),
                      _SignInWithGoogleButton(),
                      const SizedBox(height: 16),
                      _SignInWithFacebookButton(),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 16),
                      TitleDivider(
                        title:
                            AppLocalizations.of(context)!.contSignInNoAccount,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      const SizedBox(height: 16),
                      const _SignUpButton(),
                    ],
                  )
                ],
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => exit(0),
            ),
          ],
        ),
      ),
    );
  }

  void userSignInListener(
    BuildContext context,
    UserSignInState state,
  ) {
    if (state.status == SignInStatus.success) {
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.popAndPushNamed(context, RoutePaths.welcome);
      });
    }
    if (state.status == SignInStatus.fail) {
      Toasting.notifyToast(
        context,
        state.message,
      );
    }
  }
}

class _EmailTextField extends StatelessWidget {
  const _EmailTextField({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserSignInBloc, UserSignInState>(
      buildWhen: (previous, current) =>
          previous.email != current.email ||
          previous.isEmailValid != current.isEmailValid,
      builder: (context, state) {
        return EmailTextField(
          onChange: (value) => context
              .read<UserSignInBloc>()
              .add(UserSignInEmailChanged(email: value)),
          isValid: state.isEmailValid,
        );
      },
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserSignInBloc, UserSignInState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.isPasswordValid != current.isPasswordValid,
      builder: (context, state) {
        return PasswordTextField(
          onChange: (value) => context
              .read<UserSignInBloc>()
              .add(UserSignInPswChanged(password: value)),
          isValid: state.isPasswordValid,
        );
      },
    );
  }
}

class _ForgottenPasswordButton extends StatelessWidget {
  const _ForgottenPasswordButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(
        AppLocalizations.of(context)!.contSignInForgotten,
        textAlign: TextAlign.end,
      ),
      onTap: () {
        Navigator.of(context).pushNamed(RoutePaths.signInForgottenPassword);
      },
    );
  }
}

class _SignInButton extends StatelessWidget {
  const _SignInButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<UserSignInBloc>().add(const UserSignIn());
      },
      child: Row(
        children: [
          const Icon(Icons.login),
          const SizedBox(width: 8),
          Expanded(
            child: BlocBuilder<UserSignInBloc, UserSignInState>(
              builder: (context, state) {
                return Text(
                  _btnText(context, state),
                  textAlign: TextAlign.center,
                );
              },
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  String _btnText(BuildContext context, UserSignInState state) {
    switch (state.status) {
      case SignInStatus.success:
        return AppLocalizations.of(context)!.genSuccess;
      case SignInStatus.fail:
        return AppLocalizations.of(context)!.genFail;
      case SignInStatus.ready:
        return AppLocalizations.of(context)!.contSignInBtnSingIn;
      case SignInStatus.loading:
        return AppLocalizations.of(context)!.genProcessing;
    }
  }
}

class _SignInWithGoogleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Row(
        children: [
          const Icon(EvaIcons.google),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              AppLocalizations.of(context)!.contSignInBtnGoogle,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}

class _SignInWithFacebookButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Row(
        children: [
          const Icon(EvaIcons.facebook),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              AppLocalizations.of(context)!.contSignInBtnFacebook,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, RoutePaths.signUp);
      },
      child: Row(
        children: [
          const Icon(Icons.person_add),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              AppLocalizations.of(context)!.contSignInBtnSignUp,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}
