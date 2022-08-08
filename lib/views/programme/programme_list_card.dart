import 'package:blavapp/bloc/programme/data_programme/programme_bloc.dart';
import 'package:blavapp/bloc/user_data/user_data/user_data_bloc.dart';
import 'package:blavapp/components/control/button_switch.dart';
import 'package:blavapp/components/images/app_network_image.dart';
import 'package:blavapp/model/programme.dart';
import 'package:blavapp/utils/app_heros.dart';
import 'package:blavapp/utils/datetime_formatter.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:blavapp/views/programme/programme_bloc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProgrammeEntryCard extends StatelessWidget {
  final ProgEntry entry;
  final Function() onTap;

  const ProgrammeEntryCard({
    Key? key,
    required this.entry,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: _entryCard(context),
    );
  }

  Widget _entryCard(BuildContext context) {
    return Card(
      elevation: 2,
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _ProgrammeEntryInfo(entry: entry),
                        ),
                        _ProgrammeEntryUserData(
                          entry: entry,
                        ),
                      ],
                    ),
                    if (entry.desc != null) ...[
                      const Divider(),
                      Text(
                        t(entry.desc!, context),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ],
                ),
              ),
            ),
            if (entry.images.isNotEmpty)
              Expanded(
                flex: 1,
                child: _ProgrammeEntryHeroImage(entry: entry),
              ),
          ],
        ),
      ),
    );
  }
}

class _ProgrammeEntryInfo extends StatelessWidget {
  const _ProgrammeEntryInfo({
    Key? key,
    required this.entry,
  }) : super(key: key);

  final ProgEntry entry;

  @override
  Widget build(BuildContext context) {
    final Map<String, ProgPlace> places =
        BlocProvider.of<ProgrammeBloc>(context).state.programmePlaces;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Entry name
        Text(
          t(entry.name, context),
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(
          height: 5,
        ),
        // Entry time
        _buildInfoLine(
          Icons.access_time_outlined,
          AppLocalizations.of(context)!.programmeEntryTimestamp(
            datetimeToDateShort(entry.timestamp, context),
            datetimeToHours(entry.timestamp, context),
          ),
        ),
        //Entry duration
        _buildInfoLine(
          Icons.timelapse_outlined,
          AppLocalizations.of(context)!.programmeEntryDuration(entry.duration),
        ),
        // Entry place
        _buildInfoLine(
          Icons.place_outlined,
          places.containsKey(entry.placeRef)
              ? t(places[entry.placeRef]!.name, context)
              : '?${entry.placeRef}?',
        ),
        // Entry category
        _buildInfoLine(
          Icons.category_outlined,
          tProgEntryType(
            entry.type,
            context,
          ),
        ),
      ],
    );
  }

  IntrinsicHeight _buildInfoLine(IconData iconData, String text) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Icon(
            iconData,
            size: 14,
          ),
          const VerticalDivider(),
          Expanded(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgrammeEntryUserData extends StatelessWidget {
  final ProgEntry entry;

  const _ProgrammeEntryUserData({
    Key? key,
    required this.entry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataBloc, UserDataState>(
      builder: (context, state) {
        return Column(
          children: [
            ProgrammeEntryNotification(entryId: entry.id),
            ProgrammeEntryMyProgramme(entryId: entry.id),
          ],
        );
      },
    );
  }
}

class _ProgrammeEntryHeroImage extends StatelessWidget {
  const _ProgrammeEntryHeroImage({
    Key? key,
    required this.entry,
  }) : super(key: key);

  final ProgEntry entry;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: programmeEntryImgHeroTag(entry),
      child: AppNetworkImage(
        imgLocation: entry.images[0],
        asCover: true,
      ),
    );
  }
}
