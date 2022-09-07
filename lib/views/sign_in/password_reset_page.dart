import 'package:blavapp/bloc/profile/password_reset/password_reset_bloc.dart';
import 'package:blavapp/components/control/text_field.dart';
import 'package:blavapp/components/pages/page_side.dart';
import 'package:blavapp/route_generator.dart';
import 'package:blavapp/services/auth_repo.dart';
import 'package:blavapp/utils/toasting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PasswordResetPage extends StatelessWidget {
  const PasswordResetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordResetBloc(
        authRepo: context.read<AuthRepo>(),
      ),
      child: BlocListener<PasswordResetBloc, PasswordResetState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: passwordResetListener,
        child: SidePage(
          titleText: AppLocalizations.of(context)!.contPasswordResetTitle,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  AppLocalizations.of(context)!.contPasswordResetText,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4,
                ),
                const _EmailTextField(),
                const _ResetButton(),
                Text(
                  AppLocalizations.of(context)!.contPasswordResetNote,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void passwordResetListener(
    BuildContext context,
    PasswordResetState state,
  ) {
    if (state.status == PasswordResetStatus.success) {
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.popAndPushNamed(context, RoutePaths.welcome);
      });
    }
    if (state.status == PasswordResetStatus.fail) {
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
    return BlocBuilder<PasswordResetBloc, PasswordResetState>(
      buildWhen: (previous, current) =>
          previous.email != current.email ||
          previous.isValid != current.isValid,
      builder: (context, state) {
        return EmailTextField(
          onChange: (value) => context
              .read<PasswordResetBloc>()
              .add(PasswordResetEmailChanged(email: value)),
          isValid: state.isValid,
        );
      },
    );
  }
}

class _ResetButton extends StatelessWidget {
  const _ResetButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<PasswordResetBloc>().add(const PasswordReset());
      },
      child: Row(
        children: [
          const Icon(Icons.send),
          const SizedBox(width: 8),
          Expanded(
            child: BlocBuilder<PasswordResetBloc, PasswordResetState>(
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

  String _btnText(BuildContext context, PasswordResetState state) {
    switch (state.status) {
      case PasswordResetStatus.success:
        return AppLocalizations.of(context)!.genSuccess;
      case PasswordResetStatus.fail:
        return AppLocalizations.of(context)!.genFail;
      case PasswordResetStatus.ready:
        return AppLocalizations.of(context)!.genSend;
      case PasswordResetStatus.loading:
        return AppLocalizations.of(context)!.genProcessing;
    }
  }
}
