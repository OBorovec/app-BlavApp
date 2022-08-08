import 'package:blavapp/components/page_hierarchy/root_page.dart';
import 'package:blavapp/components/page_hierarchy/side_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BlocLoadingPage extends StatelessWidget {
  const BlocLoadingPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: finish localization
    return SidePage(
      titleText: 'Loading...',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const CircularProgressIndicator(),
            Text(AppLocalizations.of(context)!.blocDataLoading),
          ],
        ),
      ),
    );
  }
}
