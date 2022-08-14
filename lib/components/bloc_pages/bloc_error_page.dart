import 'package:blavapp/components/page_hierarchy/side_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BlocErrorPage extends StatelessWidget {
  final String message;

  const BlocErrorPage({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: add a button to report the problem
    return SidePage(
      titleText: AppLocalizations.of(context)!.genError,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              Icons.error,
              size: 128,
            ),
            Text(AppLocalizations.of(context)!.blocDataFail),
            Text(message),
          ],
        ),
      ),
    );
  }
}
