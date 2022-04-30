import 'package:blavapp/components/pages/page_side.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileMySupportTicketsPage extends StatelessWidget {
  const ProfileMySupportTicketsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SidePage(
        titleText: AppLocalizations.of(context)!.contProfileSupportTicketsTitle,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                  AppLocalizations.of(context)!.contProfileSupportTicketsTitle),
            ],
          ),
        ));
  }
}
