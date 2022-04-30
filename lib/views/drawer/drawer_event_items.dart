import 'package:blavapp/model/event.dart';
import 'package:blavapp/route_generator.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DrawerEventItems extends StatelessWidget {
  final Event event;
  const DrawerEventItems({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        ListTile(
          title: Text(
            t(event.name, context),
            textAlign: TextAlign.center,
          ),
          onTap: () {
            Navigator.popAndPushNamed(context, RoutePaths.eventHome);
          },
        ),
        const Divider(),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              if (event.routing.story)
                ListTile(
                  title: Text(AppLocalizations.of(context)!.drawerStory),
                  onTap: () {
                    Navigator.popAndPushNamed(context, RoutePaths.story);
                  },
                ),
              if (event.routing.programme)
                ListTile(
                  title: Text(AppLocalizations.of(context)!.drawerProgramme),
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      RoutePaths.programme,
                    );
                  },
                ),
              if (event.routing.catering)
                ListTile(
                  title: Text(AppLocalizations.of(context)!.drawerCatering),
                  onTap: () {
                    Navigator.popAndPushNamed(context, RoutePaths.catering);
                  },
                ),
              if (event.routing.degustation)
                ListTile(
                  title: Text(AppLocalizations.of(context)!.drawerDegustation),
                  onTap: () {
                    Navigator.popAndPushNamed(context, RoutePaths.degustation);
                  },
                ),
              if (event.routing.maps)
                ListTile(
                  title: Text(AppLocalizations.of(context)!.drawerMaps),
                  onTap: () {
                    Navigator.popAndPushNamed(context, RoutePaths.maps);
                  },
                ),
              if (event.routing.cosplay)
                ListTile(
                  title: Text(AppLocalizations.of(context)!.drawerCosplay),
                  onTap: () {
                    Navigator.popAndPushNamed(context, RoutePaths.cosplay);
                  },
                ),
              if (event.routing.contacts)
                ListTile(
                  title: Text(AppLocalizations.of(context)!.drawerContacts),
                  onTap: () {
                    Navigator.popAndPushNamed(context, RoutePaths.contacts);
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }
}
