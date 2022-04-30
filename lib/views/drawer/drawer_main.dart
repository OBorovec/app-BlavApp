import 'package:blavapp/bloc/app/event/event_bloc.dart';
import 'package:blavapp/views/drawer/drawer_event_items.dart';
import 'package:blavapp/views/drawer/drawer_event_picker.dart';
import 'package:blavapp/views/drawer/drawer_general_items.dart';
import 'package:blavapp/views/drawer/drawer_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        top: true,
        child: Column(
          children: <Widget>[
            const BlavDrawerHeader(),
            Expanded(
              child: BlocBuilder<EventBloc, EventState>(
                builder: (context, state) {
                  if (state.status == EventStatus.selected) {
                    return DrawerEventItems(
                      event: state.event!,
                    );
                  } else {
                    return const DrawerEventPicker();
                  }
                },
              ),
            ),
            const Divider(),
            const DrawerGeneralItems(),
          ],
        ),
      ),
    );
  }
}
