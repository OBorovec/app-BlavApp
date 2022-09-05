import 'package:blavapp/bloc/app/event/event_bloc.dart';
import 'package:blavapp/components/images/app_network_image.dart';
import 'package:blavapp/components/page_content/data_loading_page.dart';
import 'package:blavapp/components/pages/page_root.dart';
import 'package:blavapp/model/event.dart';
import 'package:blavapp/utils/datetime_formatter.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventHomePage extends StatelessWidget {
  const EventHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventBloc, EventState>(
      builder: (context, state) {
        switch (state.status) {
          case EventStatus.selected:
            return RootPage(
              titleText: t(state.event!.name, context),
              body: SingleChildScrollView(
                child: Column(children: [
                  if (state.event!.images.isNotEmpty)
                    _EventImage(event: state.event!),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        if (state.event!.sDesc != null)
                          _EventSubDescription(state: state),
                        if (state.event!.desc != null)
                          _EventDescription(state: state),
                        _EventTimes(state: state),
                      ],
                    ),
                  ),
                ]),
              ),
            );
          case EventStatus.init:
            return const DataLoadingPage();
          case EventStatus.empty:
            // TODO: add page localizations
            return RootPage(
              titleText: 'You still need to pick an event',
              body: Column(
                children: const [
                  Text('No event focused'),
                ],
              ),
            );
        }
      },
    );
  }
}

class _EventTimes extends StatelessWidget {
  final EventState state;
  const _EventTimes({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _EventDates(
              startDate: state.event!.dayStart,
              endDate: state.event!.dayEnd,
            ),
            _CountDownTimer(
              duration: state.remainingToStart,
              isOngoing: state.isOngoing,
            ),
          ],
        ),
      ],
    );
  }
}

class _EventSubDescription extends StatelessWidget {
  final EventState state;
  const _EventSubDescription({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Text(
          t(state.event!.sDesc!, context),
          style: Theme.of(context).textTheme.subtitle1,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _EventDescription extends StatelessWidget {
  final EventState state;
  const _EventDescription({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Text(
          t(state.event!.desc!, context),
        ),
      ],
    );
  }
}

class _EventImage extends StatelessWidget {
  final Event event;

  const _EventImage({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.4,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(64),
        ),
        child: AppNetworkImage(
          url: event.images[0],
          asCover: true,
        ),
      ),
    );
  }
}

class _EventDates extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;

  const _EventDates({
    Key? key,
    required this.startDate,
    required this.endDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Začíná: ${datetimeDayDate(startDate, context)}',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        Text(
          'Končí: ${datetimeDayDate(endDate, context)}',
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ],
    );
  }
}

class _CountDownTimer extends StatelessWidget {
  final Duration? duration;
  final bool isOngoing;
  const _CountDownTimer({
    Key? key,
    required this.duration,
    required this.isOngoing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isOngoing) {
      return Text(
        'Aktuálně probíhá',
        style: Theme.of(context).textTheme.subtitle2,
      );
    } else if (duration != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'Dní: ${duration!.inDays}',
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Text(
            'Hodin: ${duration!.inHours % 24}',
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}
