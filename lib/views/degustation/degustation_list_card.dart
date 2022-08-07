import 'package:blavapp/bloc/user_data/user_local_prefs/user_local_prefs_bloc.dart';
import 'package:blavapp/components/images/app_network_image.dart';
import 'package:blavapp/components/views/rating_indicator.dart';
import 'package:blavapp/model/degustation.dart';
import 'package:blavapp/utils/app_heros.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:blavapp/utils/pref_interpreter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DegustationItemCard extends StatelessWidget {
  final DegusItem item;
  final Function() onTap;
  const DegustationItemCard({
    Key? key,
    required this.item,
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
            children: [
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: _DegusItemInfo(item: item),
                    ),
                    if (item.images.isNotEmpty)
                      Expanded(
                        flex: 1,
                        child: _DegusItemHeroImage(item: item),
                      ),
                  ],
                ),
              ),
              const Divider(),
              _DegusPriceScroll(volumes: item.volumes),
            ],
          ),
        ),
      ),
    );
  }
}

class _DegusItemInfo extends StatelessWidget {
  const _DegusItemInfo({
    Key? key,
    required this.item,
  }) : super(key: key);

  final DegusItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t(item.name, context),
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline6,
            ),
            if (item.rating != null)
              AppRatingIndicator(
                rating: item.rating!,
              ),
            if (item.desc != null) ...[
              const Divider(),
              Text(
                t(item.desc!, context),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _DegusItemHeroImage extends StatelessWidget {
  const _DegusItemHeroImage({
    Key? key,
    required this.item,
  }) : super(key: key);

  final DegusItem item;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: degusItemImgHeroTag(item),
      child: AppNetworkImage(
        imgLocation: item.images[0],
        asCover: true,
      ),
    );
  }
}

class _DegusPriceScroll extends StatelessWidget {
  final List<DegusVolume> volumes;

  const _DegusPriceScroll({
    Key? key,
    required this.volumes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: volumes
            .map(
              (DegusVolume e) => _DegusPriceVolume(pv: e),
            )
            .toList(),
      ),
    );
  }
}

class _DegusPriceVolume extends StatelessWidget {
  final DegusVolume pv;
  const _DegusPriceVolume({
    Key? key,
    required this.pv,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          BlocBuilder<UserLocalPrefsBloc, UserLocalPrefsState>(
            builder: (context, state) {
              return Text(
                prefCurrency(state.currency, pv.price, context),
                style: Theme.of(context).textTheme.subtitle1,
              );
            },
          ),
          Text(t(pv.desc, context)),
        ],
      ),
    );
  }
}
