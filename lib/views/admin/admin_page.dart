import 'package:blavapp/components/page_hierarchy/root_page.dart';
import 'package:blavapp/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RootPage(
      titleText: AppLocalizations.of(context)!.adminTitle,
      body: GridView.count(crossAxisCount: 2, children: [
        _AdminButtonCard(
          text: AppLocalizations.of(context)!.adminTicketCheckerTitle,
          icon: Icons.how_to_vote,
          onTap: () => Navigator.pushNamed(
            context,
            RoutePaths.adminTicketValidation,
          ),
        ),
      ]),
    );
  }
}

class _AdminButtonCard extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function() onTap;

  const _AdminButtonCard({
    Key? key,
    required this.text,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Stack(
          children: [
            Positioned(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(
                  icon,
                  size: 64,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: width * 0.3,
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.headline5,
                    maxLines: 3,
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
