import 'package:blavapp/bloc/cosplay/data_cospaly/cosplay_bloc.dart';
import 'package:blavapp/components/images/app_network_image.dart';
import 'package:blavapp/components/pages/page_root.dart';
import 'package:blavapp/components/page_content/data_error_page.dart';
import 'package:blavapp/components/page_content/data_loading_page.dart';
import 'package:blavapp/model/cosplay.dart';
import 'package:blavapp/route_generator.dart';
import 'package:blavapp/utils/app_heros.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:blavapp/views/cosplay/cosplay_bloc_widgets.dart';
import 'package:blavapp/views/cosplay/cosplay_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CosplayPage extends StatelessWidget {
  const CosplayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CosplayBloc, CosplayState>(
      builder: (context, state) {
        switch (state.status) {
          case CosplayStatus.loaded:
            return Builder(builder: (context) {
              return RootPage(
                titleText: AppLocalizations.of(context)!.contCosplayTitle,
                body: _CosplayGallery(
                  cosplayRecords: state.cosplayRecords,
                ),
              );
            });
          case CosplayStatus.error:
            return DataErrorPage(message: state.message);
          case CosplayStatus.initial:
            return const DataLoadingPage();
        }
      },
    );
  }
}

class _CosplayGallery extends StatelessWidget {
  final List<CosplayRecord> cosplayRecords;

  const _CosplayGallery({
    Key? key,
    required this.cosplayRecords,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: cosplayRecords.map((CosplayRecord record) {
        return InkWell(
          onTap: () => Navigator.pushNamed(
            context,
            RoutePaths.cosplayRecord,
            arguments: CosplayDetailsArguments(
              record: record,
            ),
          ),
          child: Card(
            child: Column(
              children: [
                Expanded(
                    child: Hero(
                  tag: cosplayImgHeroTag(record),
                  child: AppNetworkImage(
                    url: record.profileImage,
                    asCover: true,
                  ),
                )),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        t(record.name, context),
                        style: Theme.of(context).textTheme.subtitle1,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Icon(Icons.info, size: 16),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(child: CosplayRecordDownvote(record: record)),
                    Expanded(child: CosplayRecordNeutral(record: record)),
                    Expanded(child: CosplayRecordUpvote(record: record)),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
