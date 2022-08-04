import 'package:blavapp/components/page_hierarchy/side_page.dart';
import 'package:blavapp/components/images/app_network_image.dart';
import 'package:blavapp/model/programme.dart';
import 'package:blavapp/utils/app_heros.dart';
import 'package:blavapp/utils/datetime_formatter.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProgrammeDetails extends StatelessWidget {
  final ProgEntry entry;

  const ProgrammeDetails({
    Key? key,
    required this.entry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SidePage(
      titleText: t(entry.name, context),
      body: Column(
        children: [
          if (entry.images.isNotEmpty)
            Hero(
              tag: programmeEntryImgHeroTag(entry),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  // topLeft: Radius.elliptical(40, 36),
                  bottomRight: Radius.circular(64),
                ),
                child: AppNetworkImage(
                  imgLocation: entry.images[0],
                ),
              ),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Entry name
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      t(entry.name, context),
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  // Entry time
                  _buildInfoLine(
                    Icons.access_time_outlined,
                    AppLocalizations.of(context)!.programmeEntryTimestamp(
                      datetimeToDateShort(entry.timestamp, context),
                      datetimeToHours(entry.timestamp, context),
                    ),
                    context,
                  ),
                  //Entry duration
                  _buildInfoLine(
                    Icons.timelapse_outlined,
                    AppLocalizations.of(context)!
                        .programmeEntryDuration(entry.duration),
                    context,
                  ),
                  // Entry place
                  _buildInfoLine(
                    Icons.place_outlined,
                    entry.placeRef ?? '',
                    context,
                  ),
                  // Entry category
                  _buildInfoLine(
                    Icons.category_outlined,
                    tProgEntryType(
                      entry.type,
                      context,
                    ),
                    context,
                  ),
                  const Divider(),
                  // Entry description
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(t(entry.desc!, context)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  IntrinsicHeight _buildInfoLine(
      IconData iconData, String text, BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          const VerticalDivider(),
          Icon(
            iconData,
            size: 20,
          ),
        ],
      ),
    );
  }
}

class ProgrammeDetailsArguments {
  final ProgEntry entry;

  ProgrammeDetailsArguments({required this.entry});
}
