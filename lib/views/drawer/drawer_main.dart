import 'package:blavapp/components/profile/avatar.dart';
import 'package:blavapp/route_generator.dart';
import 'package:blavapp/views/drawer/drawer_general_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        top: false,
        child: Column(
          children: <Widget>[
            // _buildHeader(context),
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

  DrawerHeader _buildHeader(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, RoutePaths.profile);
        },
        child: Stack(
          children: const [
            Center(child: BlavAvatar()),
          ],
        ),
      ),
    );
  }
}
