import 'package:blavapp/bloc/user_view/user_signin/user_sign_in_bloc.dart';
import 'package:blavapp/components/_pages/root_page.dart';
import 'package:blavapp/route_generator.dart';
import 'package:blavapp/services/auth_repo.dart';
import 'package:blavapp/utils/toasting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RootPage(
      titleText: AppLocalizations.of(context)!.signInTitle,
      body: BlocProvider(
        create: (context) => UserSignInBloc(
          authRepo: context.read<AuthRepo>(),
        ),
        child: BlocListener<UserSignInBloc, UserSignInState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: userSignInListener,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _LogoWidget(),
                Column(
                  children: [
                    _EmailTextField(),
                    const SizedBox(height: 16),
                    _PasswordTextField(),
                    const SizedBox(height: 16),
                    _SignInButton(),
                    const SizedBox(height: 16),
                    _ForgottenPasswordButton(),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 16),
                    _SignUpButton(),
                  ],
                ),
                // Column(
                //   children: [
                //     Text(AppLocalizations.of(context)!.signInProviders),
                //     const SizedBox(height: 16),
                //     _SignInWithGoogleButton(),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void userSignInListener(
    BuildContext context,
    UserSignInState state,
  ) {
    if (state.status == SignInStatus.success) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.popAndPushNamed(context, RoutePaths.profile);
      });
    }
    if (state.status == SignInStatus.fail) {
      Toasting.notifyToast(
        context,
        state.message ??
            AppLocalizations.of(context)!.signInToastingErrro(
              state.message ?? '',
            ),
      );
    }
  }
}

class _LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: add witcher flare animation
    return Container();
  }
}

class _EmailTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserSignInBloc, UserSignInState>(
      builder: (context, state) {
        return TextFormField(
          onChanged: (value) => context.read<UserSignInBloc>().add(
                UserSignInEmailChanged(email: value),
              ),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.signInEmail,
            hintText: AppLocalizations.of(context)!.signInEmail,
            errorText: !state.isEmailValid
                ? AppLocalizations.of(context)!.signInEmailError
                : null,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 10.0,
            ),
          ),
        );
      },
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserSignInBloc, UserSignInState>(
      builder: (context, state) {
        return TextFormField(
          onChanged: (value) => context.read<UserSignInBloc>().add(
                UserSignInPswChanged(password: value),
              ),
          obscureText: true,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.signInPsw,
            hintText: AppLocalizations.of(context)!.signInPsw,
            errorText: !state.isPasswordValid
                ? AppLocalizations.of(context)!.signInPswError
                : null,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 10.0,
            ),
          ),
        );
      },
    );
  }
}

class _SignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<UserSignInBloc>().add(const UserSignInFormValidate());
      },
      child: Text(AppLocalizations.of(context)!.signInBtnSignIn),
    );
  }
}

class _ForgottenPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(AppLocalizations.of(context)!.signInForgotten),
      onTap: () {
        Navigator.of(context).pushNamed(RoutePaths.profileDelete);
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, RoutePaths.signUp);
      },
      child: Text(AppLocalizations.of(context)!.signInBtnSignUp),
    );
  }
}

class _SignInWithGoogleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
