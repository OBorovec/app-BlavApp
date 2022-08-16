import 'package:blavapp/components/images/app_network_image.dart';
import 'package:blavapp/components/page_hierarchy/side_page.dart';
import 'package:blavapp/components/user/user_avatar.dart';
import 'package:blavapp/model/cosplay.dart';
import 'package:blavapp/utils/app_heros.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:blavapp/views/cosplay/cosplay_bloc_widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../components/views/title_divider.dart';

class CosplayDetails extends StatelessWidget {
  final CosplayRecord record;
  const CosplayDetails({
    Key? key,
    required this.record,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SidePage(
      titleText: t(record.name, context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                _CosplayCarouselGallery(record: record),
                Positioned(
                  bottom: 0,
                  child: _CosplayRecordInfo(record: record),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  _CosplayRecordDescription(record: record),
                  _CosplayRecordVoting(record: record),
                  const SizedBox(height: 32),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _CosplayCarouselGallery extends StatelessWidget {
  final CosplayRecord record;

  const _CosplayCarouselGallery({
    Key? key,
    required this.record,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.4,
      child: CarouselSlider(
        items: record.images
            .map((String url) => AppNetworkImage(
                  url: url,
                  asCover: true,
                ))
            .toList(),
        options: CarouselOptions(
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
          enableInfiniteScroll: true,
          height: height * 0.4,
        ),
      ),
    );
  }
}

class _CosplayRecordInfo extends StatelessWidget {
  const _CosplayRecordInfo({
    Key? key,
    required this.record,
  }) : super(key: key);

  final CosplayRecord record;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        UserAvatar(
          imageUrl: record.profileImage,
          heroTag: cosplayImgHeroTag(record),
        ),
        // Column(
        //   children: [
        //     Text(
        //       t(record.name, context),
        //       style: Theme.of(context).textTheme.headline6,
        //     ),
        //   ],
        // ),
      ],
    );
  }
}

class _CosplayRecordDescription extends StatelessWidget {
  final CosplayRecord record;

  const _CosplayRecordDescription({
    Key? key,
    required this.record,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        TitleDivider(
          title: AppLocalizations.of(context)!.genDescription,
        ),
        Text(t(record.desc, context))
      ],
    );
  }
}

class _CosplayRecordVoting extends StatelessWidget {
  final CosplayRecord record;
  const _CosplayRecordVoting({
    Key? key,
    required this.record,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        TitleDivider(
          title: AppLocalizations.of(context)!.contCosplayDetailsVoting,
        ),
        Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: CosplayRecordDownvote(record: record)),
              Expanded(child: CosplayRecordNeutral(record: record)),
              Expanded(child: CosplayRecordUpvote(record: record)),
            ],
          ),
        ),
      ],
    );
  }
}

class CosplayDetailsArguments {
  final CosplayRecord record;

  CosplayDetailsArguments({required this.record});
}
