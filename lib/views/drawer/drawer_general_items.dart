import 'package:blavapp/bloc/app/event_focus/event_focus_bloc.dart';
import 'package:blavapp/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerGeneralItems extends StatelessWidget {
  const DrawerGeneralItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(AppLocalizations.of(context)!.gwintEventsTitle),
          onTap: () {
            Navigator.pushReplacementNamed(
              context,
              RoutePaths.events,
            );
          },
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const VerticalDivider(),
              IconButton(
                icon: const Icon(Icons.change_circle),
                onPressed: () =>
                    context.read<EventFocusBloc>().add(const EventFocusClear()),
              ),
            ],
          ),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.adminTitle),
          onTap: () {
            Navigator.pushReplacementNamed(
              context,
              RoutePaths.admin,
            );
          },
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.setsTitle),
          onTap: () {
            Navigator.pushReplacementNamed(
              context,
              RoutePaths.settings,
            );
          },
        ),
      ],
    );
  }
}
