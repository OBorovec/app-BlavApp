import 'package:blavapp/bloc/profile/user_signin/user_sign_in_bloc.dart';
import 'package:blavapp/components/page_hierarchy/root_page.dart';
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
      titleText: AppLocalizations.of(context)!.contSignInTitle,
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
                const _LogoWidget(),
                Column(
                  children: const [
                    _EmailTextField(),
                    SizedBox(height: 16),
                    _PasswordTextField(),
                    SizedBox(height: 16),
                    _SignInButton(),
                    SizedBox(height: 16),
                    _ForgottenPasswordButton(),
                    SizedBox(height: 16),
                    Divider(),
                    SizedBox(height: 16),
                    _SignUpButton(),
                  ],
                ),
                Column(
                  children: [
                    Text(AppLocalizations.of(context)!.contSignInProviders),
                    const SizedBox(height: 16),
                    _SignInWithGoogleButton(),
                  ],
                ),
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
        state.message,
      );
    }
  }
}

class _LogoWidget extends StatelessWidget {
  const _LogoWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: add witcher flare animation
    return Container();
  }
}

class _EmailTextField extends StatelessWidget {
  const _EmailTextField({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserSignInBloc, UserSignInState>(
      builder: (context, state) {
        return TextField(
          autocorrect: false,
          enableSuggestions: false,
          onChanged: (value) => context.read<UserSignInBloc>().add(
                UserSignInEmailChanged(email: value),
              ),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.genEmail,
            hintText: AppLocalizations.of(context)!.genEmail,
            errorText: !state.isEmailValid
                ? AppLocalizations.of(context)!.contSignInEmailError
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
  const _PasswordTextField({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserSignInBloc, UserSignInState>(
      builder: (context, state) {
        return TextField(
          autocorrect: false,
          enableSuggestions: false,
          onChanged: (value) => context.read<UserSignInBloc>().add(
                UserSignInPswChanged(password: value),
              ),
          obscureText: true,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.genPassword,
            hintText: AppLocalizations.of(context)!.genPassword,
            errorText: !state.isPasswordValid
                ? AppLocalizations.of(context)!.contSignInPswError
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
  const _SignInButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<UserSignInBloc>().add(const UserSignIn());
      },
      child: Text(AppLocalizations.of(context)!.contSignInBtnSignIn),
    );
  }
}

class _ForgottenPasswordButton extends StatelessWidget {
  const _ForgottenPasswordButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(AppLocalizations.of(context)!.contSignInForgotten),
      onTap: () {
        Navigator.of(context).pushNamed(RoutePaths.signInForgottenPassword);
      },
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
      child: Text(AppLocalizations.of(context)!.contSignInBtnSignUp),
    );
  }
}

class _SignInWithGoogleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
