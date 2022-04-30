import 'package:blavapp/bloc/app/event/event_bloc.dart';
import 'package:blavapp/bloc/user_data/user_perms/user_perms_bloc.dart';
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
        // NOTE: Uncomment in the next versions so that the user can change the event focus.
        // ListTile(
        //   title: Text(AppLocalizations.of(context)!.contEventsTitle),
        //   onTap: () {
        //     Navigator.popAndPushNamed(context, RoutePaths.events);
        //   },
        //   trailing: Row(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       const VerticalDivider(),
        //       IconButton(
        //         icon: const Icon(Icons.change_circle),
        //         onPressed: () =>
        //             context.read<EventBloc>().add(const EventClear()),
        //       ),
        //     ],
        //   ),
        // ),
        if (context.read<UserPermsBloc>().state.isStaff ||
            context.read<UserPermsBloc>().state.isAdmin)
          ListTile(
            title: Text(AppLocalizations.of(context)!.adminTitle),
            onTap: () {
              Navigator.popAndPushNamed(context, RoutePaths.admin);
            },
          ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.settingsTitle),
          onTap: () {
            Navigator.popAndPushNamed(
              context,
              RoutePaths.settings,
            );
          },
        ),
      ],
    );
  }
}
