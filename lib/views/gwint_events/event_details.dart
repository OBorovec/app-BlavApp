import 'package:blavapp/components/page_hierarchy/side_page.dart';
import 'package:blavapp/model/event.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:flutter/material.dart';

class EventDetails extends StatelessWidget {
  final Event event;
  const EventDetails({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SidePage(
      titleText: t(event.name, context),
      body: Center(
        child: Text(t(event.desc!, context)),
      ),
    );
  }
}

class EventDetailsArguments {
  final Event event;

  EventDetailsArguments({required this.event});
}
