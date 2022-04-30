import 'package:blavapp/bloc/app/auth/auth_bloc.dart';
import 'package:blavapp/bloc/app/event/event_bloc.dart';
import 'package:blavapp/bloc/app/init/init_bloc.dart';
import 'package:blavapp/route_generator.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:blavapp/utils/model_localization.dart';
// import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rive/rive.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => InitBloc(
        dataRepo: context.read<DataRepo>(),
        authBloc: context.read<AuthBloc>(),
        eventBloc: context.read<EventBloc>(),
      ),
      child: BlocListener<InitBloc, InitState>(
        listener: (context, state) {
          if (state.isAuth && state.hasEvent && state.isAnimFinished) {
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.popAndPushNamed(context, RoutePaths.eventHome);
            });
          }
        },
        child: Scaffold(
          body: Column(
            children: [
              _WelcomeAnimation(width: width),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    _WelcomeUser(),
                    _WelcomeEvent(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WelcomeAnimation extends StatelessWidget {
  const _WelcomeAnimation({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: width,
      width: width,
      child: const RiveAnimation.asset(
        "assets/rive/BlaviconIconDark.riv",
        alignment: Alignment.center,
        fit: BoxFit.contain,
        animations: ["enter"],
      ),
      //   child: const FlareActor("assets/flare/WitcherWolf.flr",
      //       alignment: Alignment.center,
      //       fit: BoxFit.contain,
      //       animation: "compose"),
    );
  }
}

class _WelcomeUser extends StatelessWidget {
  const _WelcomeUser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        switch (state.status) {
          case AuthStatus.init:
            return Text(
              AppLocalizations.of(context)!.contWelcomeLoadingUser,
              textAlign: TextAlign.center,
            );
          case AuthStatus.unauth:
            return Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.contWelcomeNoUser,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).popAndPushNamed(RoutePaths.signIn);
                  },
                  child: Text(
                      AppLocalizations.of(context)!.contWelcomeBtnGoToSignIn),
                ),
              ],
            );
          case AuthStatus.auth:
            return Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.contWelcomeUserText,
                ),
                Text(state.user!.displayName!,
                    style: Theme.of(context).textTheme.headline6),
              ],
            );
        }
      },
    );
  }
}

class _WelcomeEvent extends StatelessWidget {
  const _WelcomeEvent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventBloc, EventState>(
      builder: (context, state) {
        switch (state.status) {
          case EventStatus.init:
            return Text(
              AppLocalizations.of(context)!.contWelcomeLoadingEvent,
              textAlign: TextAlign.center,
            );
          case EventStatus.empty:
            return Text(
              AppLocalizations.of(context)!.contWelcomeNoEvent,
              textAlign: TextAlign.center,
            );
          case EventStatus.selected:
            return Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.contWelcomeEventText,
                ),
                Text(t(state.event!.name, context),
                    style: Theme.of(context).textTheme.headline6),
              ],
            );
        }
      },
    );
  }
}
