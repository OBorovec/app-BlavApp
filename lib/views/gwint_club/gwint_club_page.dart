import 'package:blavapp/components/page_hierarchy/root_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GwintHomePage extends StatelessWidget {
  const GwintHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RootPage(
      titleText: AppLocalizations.of(context)!.gwintTitle,
      body: const Center(
        child: Text('Gwint Home Page'),
      ),
    );
  }
}
