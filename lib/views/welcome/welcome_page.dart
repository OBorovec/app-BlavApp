import 'package:blavapp/bloc/auth/auth_bloc.dart';
import 'package:blavapp/components/_pages/root_static_page.dart';
import 'package:blavapp/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RootStaticPage(
      titleText: '',
      body: Column(
        children: [
          const Expanded(
            child: Center(child: Text('TBD: Some dynamic text')),
          ),
          Expanded(
            child: Center(
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is UserAuthenticated) {
                    Future.delayed(const Duration(seconds: 1), () {
                      Navigator.popAndPushNamed(context, RoutePaths.gwint);
                    });
                  }
                },
                builder: (context, state) {
                  if (state is UserNotAuthenticated) {
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
                  } else if (state is UserAuthenticated) {
                    return Text(
                      AppLocalizations.of(context)!
                          .welcomeUserText(state.user.displayName!),
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
