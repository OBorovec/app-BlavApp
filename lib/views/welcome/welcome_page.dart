import 'package:blavapp/bloc/app_state/auth/auth_bloc.dart';
import 'package:blavapp/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            child: Center(child: Text('TBD: Some dynamic text')),
          ),
          Expanded(
            child: Center(
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state.status == AuthStatus.authenticated) {
                    Future.delayed(const Duration(seconds: 1), () {
                      Navigator.popAndPushNamed(context, RoutePaths.club);
                    });
                  }
                },
                builder: (context, state) {
                  if (state.status == AuthStatus.unauthenticated) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.welcomeGoToSignInReq,
                          textAlign: TextAlign.center,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(RoutePaths.signIn);
                          },
                          child: Text(AppLocalizations.of(context)!
                              .welcomeBtnGoToSignIn),
                        ),
                      ],
                    );
                  } else if (state.status == AuthStatus.authenticated) {
                    return Text(
                      AppLocalizations.of(context)!
                          .welcomeUserText(state.user!.displayName!),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
