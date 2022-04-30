import 'package:blavapp/components/pages/page_side.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PasswordResetPage extends StatelessWidget {
  const PasswordResetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SidePage(
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
            ElevatedButton(
              onPressed: () {},
              child: Text(AppLocalizations.of(context)!.genSend),
            )
          ],
        ),
      ),
    );
  }
}

class _EmailTextField extends StatelessWidget {
  const _EmailTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      autocorrect: false,
      enableSuggestions: false,
      onChanged: (value) => null,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.genEmail,
        hintText: AppLocalizations.of(context)!.genEmail,
        errorMaxLines: 2,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 10.0,
        ),
        icon: const Icon(Icons.mail),
      ),
    );
  }
}
