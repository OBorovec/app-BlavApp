import 'package:blavapp/components/pages/page_plain.dart';
import 'package:blavapp/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RestrictAuth extends StatelessWidget {
  const RestrictAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlainPage(
      titleText: AppLocalizations.of(context)!.contRestrictTitle,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.contRestrictTextAuth),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).popAndPushNamed(RoutePaths.welcome),
              child: Text(
                AppLocalizations.of(context)!.contRestrictBtnWelcome,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).popAndPushNamed(RoutePaths.signIn),
              child: Text(
                AppLocalizations.of(context)!.contRestrictBtnSignIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
