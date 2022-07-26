import 'package:blavapp/bloc/user_data/user_data/user_data_bloc.dart';
import 'package:blavapp/bloc/profile/user_signup/user_sign_up_bloc.dart';
import 'package:blavapp/components/control/text_field.dart';
import 'package:blavapp/components/pages/page_side.dart';
import 'package:blavapp/route_generator.dart';
import 'package:blavapp/services/auth_repo.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:blavapp/utils/toasting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SidePage(
        titleText: AppLocalizations.of(context)!.contSignUpTitle,
        // body: Container(),
        body: BlocProvider(
          create: (context) => UserSignUpBloc(
            authRepo: context.read<AuthRepo>(),
            dataRepo: context.read<DataRepo>(),
            userDataBloc: context.read<UserDataBloc>(),
          ),
          child: BlocListener<UserSignUpBloc, UserSignUpState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: userSignUpListener,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _EmailTextField(),
                        const SizedBox(height: 16),
                        const _PasswordTextField(),
                        const SizedBox(height: 16),
                        _NickTextField(),
                        const SizedBox(height: 16),
                        _SignUpButton(),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text(AppLocalizations.of(context)!.contSignUnProviders),
                      const SizedBox(height: 16),
                      _SignUpWithGoogleButton(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void userSignUpListener(
    BuildContext context,
    UserSignUpState state,
  ) {
    if (state.status == SignUpStatus.success) {
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.popAndPushNamed(context, RoutePaths.welcome);
      });
    }
    if (state.status == SignUpStatus.fail) {
      Toasting.notifyToast(
        context,
        state.message,
      );
    }
  }
}

class _EmailTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserSignUpBloc, UserSignUpState>(
      buildWhen: (previous, current) =>
          previous.email != current.email ||
          previous.isEmailValid != current.isEmailValid,
      builder: (context, state) {
        return EmailTextField(
          onChange: (value) => context
              .read<UserSignUpBloc>()
              .add(UserSignUpEmailChanged(email: value)),
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
    return BlocBuilder<UserSignUpBloc, UserSignUpState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.isPasswordValid != current.isPasswordValid,
      builder: (context, state) {
        return PasswordTextField(
          onChange: (value) => context
              .read<UserSignUpBloc>()
              .add(UserSignUpPswChanged(password: value)),
          isValid: state.isPasswordValid,
        );
      },
    );
  }
}

class _NickTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserSignUpBloc, UserSignUpState>(
      buildWhen: (previous, current) =>
          previous.nickName != current.nickName ||
          previous.isNickNameValid != current.isNickNameValid,
      builder: (context, state) {
        return NickTextField(
          onChange: (value) => context
              .read<UserSignUpBloc>()
              .add(UserSignUpNNChanged(nickName: value)),
          isValid: state.isNickNameValid,
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserSignUpBloc, UserSignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            context.read<UserSignUpBloc>().add(const UserSignUp());
          },
          child: _signUpStateToButton(context, state.status),
        );
      },
    );
  }

  Widget _signUpStateToButton(BuildContext context, SignUpStatus status) {
    if (status == SignUpStatus.loading) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(AppLocalizations.of(context)!.contSignUpBtnLoading),
          const SizedBox(width: 10),
          SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              color: Theme.of(context).focusColor,
            ),
          ),
        ],
      );
    } else if (status == SignUpStatus.success) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(AppLocalizations.of(context)!.contSignUpBtnSuccess),
          const SizedBox(width: 10),
          SizedBox(
            height: 20,
            width: 20,
            child: Icon(
              Icons.check,
              color: Theme.of(context).focusColor,
            ),
          ),
        ],
      );
    } else if (status == SignUpStatus.fail) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(AppLocalizations.of(context)!.contSignUpBtnFail),
          const SizedBox(width: 10),
          SizedBox(
            height: 20,
            width: 20,
            child: Icon(
              Icons.error,
              color: Theme.of(context).focusColor,
            ),
          ),
        ],
      );
    }
    return Text(AppLocalizations.of(context)!.contSignUpBtnSignUp);
  }
}

class _SignUpWithGoogleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container();
  }
}
