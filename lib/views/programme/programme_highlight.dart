import 'package:blavapp/bloc/programme/highlight_programme/highlight_programme_bloc.dart';
import 'package:blavapp/components/views/title_divider.dart';
import 'package:blavapp/model/programme.dart';
import 'package:blavapp/route_generator.dart';
import 'package:blavapp/utils/datetime_formatter.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:blavapp/views/programme/programme_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProgrammeHighlight extends StatelessWidget {
  const ProgrammeHighlight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HighlightProgrammeBloc>(context)
        .add(const UpdateViewData());
    return BlocBuilder<HighlightProgrammeBloc, HighlightProgrammeState>(
      builder: (context, state) {
        return Column(
          children: [
            TitleDivider(
              title: AppLocalizations.of(context)!.progHighlightOngoing,
            ),
            // _HighlightTitle(
            //   title: AppLocalizations.of(context)!.progHighlightOngoing,
            // ),
            state.ongoingEntries.isNotEmpty
                ? _HorizontalHighlightEntryList(
                    entries: state.ongoingEntries,
                  )
                : _HighlightEmpty(
                    text:
                        AppLocalizations.of(context)!.progHighlightOngoingEmpty,
                  ),
            TitleDivider(
              title: AppLocalizations.of(context)!.progHighlightUpcoming,
            ),
            // _HighlightTitle(
            //   title: AppLocalizations.of(context)!.progHighlightUpcoming,
            // ),
            state.upcomingEntries.isNotEmpty
                ? _HorizontalHighlightEntryList(
                    entries: state.upcomingEntries,
                  )
                : _HighlightEmpty(
                    text: AppLocalizations.of(context)!
                        .progHighlightUpcomingEmpty,
                  ),
            TitleDivider(
              title: AppLocalizations.of(context)!.progHighlightMyUpcoming,
            ),
            // _HighlightTitle(
            //   title: AppLocalizations.of(context)!.progHighlightMyUpcoming,
            // ),
            state.upcomingMyEntries.isNotEmpty
                ? Expanded(
                    child: _VerticalHighlightEntryList(
                      entries: state.upcomingMyEntries,
                    ),
                  )
                : _HighlightEmpty(
                    text: AppLocalizations.of(context)!
                        .progHighlightMyUpcomingEmpty,
                  ),
          ],
        );
      },
    );
  }
}

class _HighlightTitle extends StatelessWidget {
  final String title;
  const _HighlightTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
    );
  }
}

class _HighlightEmpty extends StatelessWidget {
  final String text;
  const _HighlightEmpty({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
      ),
    );
  }
}

class _HorizontalHighlightEntryList extends StatelessWidget {
  final List<ProgEntry> entries;

  const _HorizontalHighlightEntryList({
    Key? key,
    required this.entries,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: entries
            .map(
              (ProgEntry entry) => _HorizontalEntryCard(entry: entry),
            )
            .toList(),
      ),
    );
  }
}

class _HorizontalEntryCard extends StatelessWidget {
  final ProgEntry entry;
  const _HorizontalEntryCard({
    Key? key,
    required this.entry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () => Navigator.pushNamed(
        context,
        RoutePaths.programmeEntry,
        arguments: ProgrammeDetailsArguments(
          entry: entry,
        ),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                t(entry.name, context),
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                tProgEntryType(entry.type, context),
                style: Theme.of(context).textTheme.subtitle2,
              ),
              Text(
                '${datetimeToHours(entry.timestamp, context)} - ${datetimeToHours(entry.timestamp.add(Duration(minutes: entry.duration)), context)}',
                // style: Theme.of(context).textTheme.subtitle2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VerticalHighlightEntryList extends StatelessWidget {
  final List<ProgEntry> entries;

  const _VerticalHighlightEntryList({
    Key? key,
    required this.entries,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: entries
            .map(
              (ProgEntry entry) => _VerticalEntryCard(entry: entry),
            )
            .toList(),
      ),
    );
  }
}

class _VerticalEntryCard extends StatelessWidget {
  final ProgEntry entry;
  const _VerticalEntryCard({
    Key? key,
    required this.entry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () => Navigator.pushNamed(
        context,
        RoutePaths.programmeEntry,
        arguments: ProgrammeDetailsArguments(
          entry: entry,
        ),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  t(entry.name, context),
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              Text(
                '${datetimeToHours(entry.timestamp, context)} - ${datetimeToHours(entry.timestamp.add(Duration(minutes: entry.duration)), context)}',
                // style: Theme.of(context).textTheme.subtitle2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
