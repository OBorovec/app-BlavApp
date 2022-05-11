import 'package:blavapp/route_generator.dart';
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
            BlavDrawerHeader(),
            // Expanded(
            //   child: BlocBuilder<EventFocusBloc, EventFocusState>(
            //     builder: (context, state) {
            //       if (state is NoEventFocus) {
            //         return const DrawerEventPicker();
            //       } else if (state is EventFocused) {
            //         return DrawerEventItems(
            //           event: state.event,
            //         );
            //       } else {
            //         return const Text('error');
            //       }
            //     },
            //   ),
            // ),
            // const Divider(),
            const DrawerGeneralItems(),
          ],
        ),
      ),
    );
  }
}
