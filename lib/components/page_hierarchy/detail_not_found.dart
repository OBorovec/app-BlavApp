import 'package:blavapp/components/page_hierarchy/side_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetailNotFoundPage extends StatelessWidget {
  final String message;

  const DetailNotFoundPage({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SidePage(
      titleText: AppLocalizations.of(context)!.genMissing,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              Icons.question_mark,
              size: 128,
            ),
            Text(message),
          ],
        ),
      ),
    );
  }
}
