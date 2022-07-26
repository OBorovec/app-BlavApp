import 'package:blavapp/components/pages/page_side.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DataErrorPage extends StatelessWidget {
  final String message;

  const DataErrorPage({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: add a button to report the problem
    return SidePage(
      titleText: AppLocalizations.of(context)!.genError,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              Icons.error,
              size: 128,
            ),
            Text(AppLocalizations.of(context)!.compPageDataFail),
            Text(message),
          ],
        ),
      ),
    );
  }
}
