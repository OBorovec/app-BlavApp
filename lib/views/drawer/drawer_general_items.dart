import 'package:blavapp/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerGeneralItems extends StatelessWidget {
  const DrawerGeneralItems();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(AppLocalizations.of(context)!.gwintTitle),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, RoutePaths.gwint);
          },
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.eventsTitle),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, RoutePaths.events);
          },
          // trailing: Row(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     const VerticalDivider(),
          //     IconButton(
          //       icon: const Icon(Icons.change_circle),
          //       onPressed: () =>
          //           context.read<EventFocusBloc>().add(const EventFocusClear()),
          //     ),
          //   ],
          // ),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.setsTitle),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, RoutePaths.settings);
          },
        ),
      ],
    );
  }
}
