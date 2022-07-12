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
        ListTile(
          title: Text(
            t(event.name, context),
            textAlign: TextAlign.center,
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, RoutePaths.eventHome);
          },
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              if (event.routing.programme)
                ListTile(
                  title: Text(AppLocalizations.of(context)!.progTitle),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, RoutePaths.programme);
                  },
                ),
              if (event.routing.catering)
                ListTile(
                  title: Text(AppLocalizations.of(context)!.caterTitle),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, RoutePaths.catering);
                  },
                ),
              if (event.routing.maps)
                ListTile(
                  title: Text(AppLocalizations.of(context)!.mapsTitle),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, RoutePaths.maps);
                  },
                ),
              if (event.routing.divisions)
                ListTile(
                  title: Text(AppLocalizations.of(context)!.divsTitle),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, RoutePaths.divisions);
                  },
                ),
              if (event.routing.cosplay)
                ListTile(
                  title: Text(AppLocalizations.of(context)!.cospTitle),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, RoutePaths.cosplay);
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }
}