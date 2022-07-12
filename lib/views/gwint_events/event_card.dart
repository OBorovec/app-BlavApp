import 'package:blavapp/model/event.dart';
import 'package:blavapp/utils/datetime_formatter.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final Function() onTapHandler;
  const EventCard({
    Key? key,
    required this.event,
    required this.onTapHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapHandler,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                title: Text(t(event.name, context)),
                subtitle: Text(
                  formatTimeRange(
                    event.timestampStart,
                    event.timestampEnd,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
