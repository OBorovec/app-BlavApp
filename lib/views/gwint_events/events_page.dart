import 'package:blavapp/bloc/event_list/events_bloc.dart';
import 'package:blavapp/components/_pages/root_page.dart';
import 'package:blavapp/model/event.dart';
import 'package:blavapp/route_generator.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:blavapp/utils/toasting.dart';
import 'package:blavapp/views/gwint_events/event_card.dart';
import 'package:blavapp/views/gwint_events/event_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RootPage(
      titleText: AppLocalizations.of(context)!.gwintEventsTitle,
      body: BlocProvider(
        create: (context) => EventsBloc(
          dataRepo: context.read<DataRepo>(),
        )..add(LoadEvents()),
        child: BlocConsumer<EventsBloc, EventsState>(
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
                      (Event event) => EventCard(
                        event: event,
                        onTapHandler: () => _navigateToDetails(
                          event,
                          context,
                        ),
                      ),
                    ),
                    const Divider(),
                    Text(
                      AppLocalizations.of(context)!.gwintEventsPastEvents,
                    ),
                    ...state.pastEvents.map(
                      (Event event) => EventCard(
                        event: event,
                        onTapHandler: () => _navigateToDetails(
                          event,
                          context,
                        ),
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
