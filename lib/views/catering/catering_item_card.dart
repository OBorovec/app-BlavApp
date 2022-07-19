import 'package:blavapp/bloc/user_local_prefs/user_local_prefs_bloc.dart';
import 'package:blavapp/components/images/app_network_image.dart';
import 'package:blavapp/constants/icons.dart';
import 'package:blavapp/model/cater_item.dart';
import 'package:blavapp/utils/app_heros.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CateringItemCard extends StatelessWidget {
  final CaterItem item;
  final Function() onTap;
  const CateringItemCard({
    Key? key,
    required this.item,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          _CateringItemInfo(item: item),
                          if (item.desc != null) ...[
                            const Divider(),
                            Text(
                              t(item.desc!, context),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ],
                      ),
                    ),
                  ),
                  if (item.images.isNotEmpty)
                    Expanded(
                      flex: 1,
                      child: _CateringItemHeroImage(item: item),
                    ),
                ],
              ),
            ),
            const Divider(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: item.volumes
                    .map((CatVolume e) => _CaterPriceVolume(pv: e))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CateringItemInfo extends StatelessWidget {
  const _CateringItemInfo({
    Key? key,
    required this.item,
  }) : super(key: key);

  final CaterItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t(item.name, context),
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            if (item.vegetarian)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ImageIcon(AppIcons.vegetarian),
              ),
            if (item.vegan)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ImageIcon(AppIcons.vegan),
              ),
            if (item.glutenFree)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ImageIcon(AppIcons.glutenFree),
              ),
          ],
        ),
      ],
    );
  }
}

class _CateringItemHeroImage extends StatelessWidget {
  const _CateringItemHeroImage({
    Key? key,
    required this.item,
  }) : super(key: key);

  final CaterItem item;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: caterItemImgHeroTag(item),
      child: AppNetworkImage(
        imgLocation: item.images[0],
        asCover: true,
      ),
    );
  }
}

class _CaterPriceVolume extends StatelessWidget {
  final CatVolume pv;
  const _CaterPriceVolume({
    Key? key,
    required this.pv,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Text(t(pv.desc, context)),
          Text(AppLocalizations.of(context)!.somethingForPrice),
          BlocBuilder<UserLocalPrefsBloc, UserLocalPrefsState>(
            builder: (context, state) {
              if (state.currency == UserCurrencyPref.eur &&
                  pv.price.containsKey('eur')) {
                return Text(
                  '${pv.price['eur']} eur',
                  style: Theme.of(context).textTheme.headline6,
                );
              } else {
                return Text(
                  '${pv.price['czk']} czk',
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
