import 'package:blavapp/bloc/profile/user_delete/user_delete_bloc.dart';
import 'package:blavapp/components/control/text_field.dart';
import 'package:blavapp/components/pages/page_side.dart';
import 'package:blavapp/route_generator.dart';
import 'package:blavapp/services/auth_repo.dart';
import 'package:blavapp/utils/toasting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserProfileDeletePage extends StatelessWidget {
  const UserProfileDeletePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserDeleteBloc(
        authRepo: context.read<AuthRepo>(),
      ),
      child: BlocListener<UserDeleteBloc, UserDeleteState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: userDeleteListener,
        child: SidePage(
          titleText: AppLocalizations.of(context)!.contProfileDeleteTitle,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    AppLocalizations.of(context)!.contProfileDeleteText,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const _PasswordTextField(),
                  const _DeleteButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void userDeleteListener(
    BuildContext context,
    UserDeleteState state,
  ) {
    if (state.status == UserDeleteStatus.success) {
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.popAndPushNamed(context, RoutePaths.welcome);
      });
    }
    if (state.status == UserDeleteStatus.fail) {
      Toasting.notifyToast(
        context,
        state.message,
      );
    }
  }
}

class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDeleteBloc, UserDeleteState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.isPasswordValid != current.isPasswordValid,
      builder: (context, state) {
        return PasswordTextField(
          onChange: (value) => context
              .read<UserDeleteBloc>()
              .add(UserDeletePswChanged(password: value)),
          isValid: state.isPasswordValid,
        );
      },
    );
  }
}

class _DeleteButton extends StatelessWidget {
  const _DeleteButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<UserDeleteBloc>().add(const UserDelete());
      },
      child: Row(
        children: [
          const Icon(Icons.delete),
          const SizedBox(width: 8),
          Expanded(
            child: BlocBuilder<UserDeleteBloc, UserDeleteState>(
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

  String _btnText(BuildContext context, UserDeleteState state) {
    switch (state.status) {
      case UserDeleteStatus.success:
        return AppLocalizations.of(context)!.genSuccess;
      case UserDeleteStatus.fail:
        return AppLocalizations.of(context)!.genFail;
      case UserDeleteStatus.ready:
        return AppLocalizations.of(context)!.genDelete;
      case UserDeleteStatus.loading:
        return AppLocalizations.of(context)!.genProcessing;
    }
  }
}
