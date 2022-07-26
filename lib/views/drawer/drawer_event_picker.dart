import 'package:blavapp/bloc/app/event/event_bloc.dart';
import 'package:blavapp/bloc/events/event_list/event_list_bloc.dart';
import 'package:blavapp/model/event.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:blavapp/utils/datetime_formatter.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:blavapp/utils/toasting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerEventPicker extends StatelessWidget {
  const DrawerEventPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventListBloc(
        dataRepo: context.read<DataRepo>(),
      )..add(LoadEvents()),
      child: BlocConsumer<EventListBloc, EventListState>(
        listener: (context, state) {
          if (state is EventsFailState) {
            Toasting.notifyToast(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is EventsLoadedState) {
            return _buildEventPickerList(context, state.upComingEvents);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildEventPickerList(BuildContext context, List<Event> events) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: ListView.builder(
          itemCount: events.length,
          itemBuilder: (BuildContext context, int index) {
            return DrawerEventCard(
              event: events[index],
              onTap: () => {
                context.read<EventBloc>().add(
                      EventSelected(eventID: events[index].id),
                    )
              },
            );
          },
        ),
      ),
    );
  }
}

class DrawerEventCard extends StatelessWidget {
  final Event event;
  final Function() onTap;
  const DrawerEventCard({
    Key? key,
    required this.event,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
                    event.dayStart,
                    event.dayEnd,
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
