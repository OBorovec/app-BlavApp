import 'package:blavapp/bloc/programme/data_programme/programme_bloc.dart';
import 'package:blavapp/bloc/programme/highlight_programme/highlight_programme_bloc.dart';
import 'package:blavapp/components/views/collapsable_text_section.dart';
import 'package:blavapp/components/views/title_divider.dart';
import 'package:blavapp/model/common.dart';
import 'package:blavapp/model/programme.dart';
import 'package:blavapp/route_generator.dart';
import 'package:blavapp/utils/datetime_formatter.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:blavapp/views/programme/programme_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProgrammeHighlight extends StatefulWidget {
  const ProgrammeHighlight({Key? key}) : super(key: key);

  @override
  State<ProgrammeHighlight> createState() => _ProgrammeHighlightState();
}

class _ProgrammeHighlightState extends State<ProgrammeHighlight> {
  List<bool> showFullExtrasText = [];
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HighlightProgrammeBloc>(context)
        .add(const UpdateViewData());
    List<Extras> extras =
        BlocProvider.of<ProgrammeBloc>(context).state.programme.extras;
    if (showFullExtrasText.isEmpty) {
      showFullExtrasText = List<bool>.filled(
        extras.length,
        false,
      );
    }
    return BlocBuilder<HighlightProgrammeBloc, HighlightProgrammeState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _ProgrammeHighlightOnGoing(state: state),
                _ProgrammeHighlightUpComing(state: state),
                _ProgrammeHighlightMyUpComing(state: state),
                const SizedBox(height: 8),
                ...extras.map(
                  (Extras e) {
                    int index = extras.indexOf(e);
                    return CollapsableTextSection(
                      title: t(e.title, context),
                      body: t(e.body, context),
                      isExpanded: showFullExtrasText[index],
                      onToggle: () => setState(() {
                        showFullExtrasText[index] = !showFullExtrasText[index];
                      }),
                    );
                  },
                ).toList(),
                const SizedBox(height: 64),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProgrammeHighlightOnGoing extends StatelessWidget {
  final HighlightProgrammeState state;

  const _ProgrammeHighlightOnGoing({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        TitleDivider(
          title: AppLocalizations.of(context)!.contProgrammeHighlightOngoing,
        ),
        state.ongoingEntries.isNotEmpty
            ? _HorizontalHighlightEntryList(
                entries: state.ongoingEntries,
              )
            : _HighlightEmpty(
                text: AppLocalizations.of(context)!
                    .contProgrammeHighlightOngoingEmpty,
              ),
      ],
    );
  }
}

class _ProgrammeHighlightUpComing extends StatelessWidget {
  final HighlightProgrammeState state;
  const _ProgrammeHighlightUpComing({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        TitleDivider(
          title: AppLocalizations.of(context)!.contProgrammeHighlightUpcoming,
        ),
        state.upcomingEntries.isNotEmpty
            ? _HorizontalHighlightEntryList(
                entries: state.upcomingEntries,
              )
            : _HighlightEmpty(
                text: AppLocalizations.of(context)!
                    .contProgrammeHighlightUpcomingEmpty,
              ),
      ],
    );
  }
}

class _ProgrammeHighlightMyUpComing extends StatelessWidget {
  final HighlightProgrammeState state;

  const _ProgrammeHighlightMyUpComing({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        TitleDivider(
          title: AppLocalizations.of(context)!.contProgrammeHighlightMyUpcoming,
        ),
        state.upcomingMyEntries.isNotEmpty
            ? _VerticalHighlightEntryList(
                entries: state.upcomingMyEntries,
              )
            : _HighlightEmpty(
                text: AppLocalizations.of(context)!
                    .contProgrammeHighlightMyUpcomingEmpty,
              ),
      ],
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
      child: Card(
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
      ),
    );
  }
}

class _HorizontalHighlightEntryList extends StatelessWidget {
  final List<ProgrammeEntry> entries;

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
              (ProgrammeEntry entry) => _HorizontalEntryCard(entry: entry),
            )
            .toList(),
      ),
    );
  }
}

class _HorizontalEntryCard extends StatelessWidget {
  final ProgrammeEntry entry;
  const _HorizontalEntryCard({
    Key? key,
    required this.entry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
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
                tProgrammeEntryType(entry.type, context),
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
  final List<ProgrammeEntry> entries;

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
              (ProgrammeEntry entry) => _VerticalEntryCard(entry: entry),
            )
            .toList(),
      ),
    );
  }
}

class _VerticalEntryCard extends StatelessWidget {
  final ProgrammeEntry entry;
  const _VerticalEntryCard({
    Key? key,
    required this.entry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
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
