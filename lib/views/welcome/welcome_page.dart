import 'package:blavapp/bloc/app/auth/auth_bloc.dart';
import 'package:blavapp/route_generator.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: width,
            width: width,
            child: const FlareActor("assets/flare/WitcherWolf.flr",
                alignment: Alignment.center,
                fit: BoxFit.contain,
                animation: "compose"),
          ),
          Expanded(
            child: Center(
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state.status == AuthStatus.authenticated) {
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.popAndPushNamed(context, RoutePaths.eventHome);
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
                          AppLocalizations.of(context)!
                              .contWelcomeGoToSignInReq,
                          textAlign: TextAlign.center,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .popAndPushNamed(RoutePaths.signIn);
                          },
                          child: Text(AppLocalizations.of(context)!
                              .contWelcomeBtnGoToSignIn),
                        ),
                      ],
                    );
                  } else if (state.status == AuthStatus.authenticated) {
                    return Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.contWelcomeUserText,
                        ),
                        Text(state.user!.displayName!,
                            style: Theme.of(context).textTheme.headline6),
                      ],
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
