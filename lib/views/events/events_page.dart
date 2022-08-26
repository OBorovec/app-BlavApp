import 'package:blavapp/bloc/app/event/event_bloc.dart';
import 'package:blavapp/bloc/events/event_list/event_list_bloc.dart';
import 'package:blavapp/components/pages/page_root.dart';
import 'package:blavapp/model/event.dart';
import 'package:blavapp/route_generator.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:blavapp/utils/datetime_formatter.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:blavapp/utils/toasting.dart';
import 'package:blavapp/views/events/event_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RootPage(
      titleText: AppLocalizations.of(context)!.contEventsTitle,
      body: BlocProvider(
        create: (context) => EventListBloc(
          dataRepo: context.read<DataRepo>(),
        ),
        child: BlocConsumer<EventListBloc, EventListState>(
          listener: (context, state) {
            if (state is EventsFailState) {
              Toasting.notifyToast(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is EventsLoadedState) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ...state.upComingEvents.map(
                      (Event event) => _EventCard(
                        event: event,
                        onTap: () => _navigateToDetails(
                          event,
                          context,
                        ),
                        onFocusSelection: event.canBeFocused
                            ? () {
                                context.read<EventBloc>().add(
                                      EventSelected(eventID: event.id),
                                    );
                                Navigator.popAndPushNamed(
                                    context, RoutePaths.eventHome);
                              }
                            : null,
                      ),
                    ),
                    const Divider(),
                    Text(
                      AppLocalizations.of(context)!.contEventsPastEvents,
                    ),
                    ...state.pastEvents.map(
                      (Event event) => _EventCard(
                        event: event,
                        onTap: () => _navigateToDetails(
                          event,
                          context,
                        ),
                        onFocusSelection: event.canBeFocused
                            ? () {
                                context.read<EventBloc>().add(
                                      EventSelected(eventID: event.id),
                                    );
                                Navigator.popAndPushNamed(
                                    context, RoutePaths.eventHome);
                              }
                            : null,
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is EventsFailState) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  void _navigateToDetails(
    Event event,
    BuildContext context,
  ) {
    Navigator.pushNamed(
      context,
      RoutePaths.eventDetail,
      arguments: EventDetailsArguments(
        event: event,
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  final Event event;
  final Function() onTap;
  final Function()? onFocusSelection;
  const _EventCard({
    Key? key,
    required this.event,
    required this.onTap,
    required this.onFocusSelection,
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
                trailing: IconButton(
                  onPressed: onFocusSelection,
                  icon: const Icon(Icons.arrow_forward),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
