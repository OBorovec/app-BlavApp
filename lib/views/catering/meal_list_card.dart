import 'package:blavapp/bloc/catering/data_catering/catering_bloc.dart';
import 'package:blavapp/bloc/user_data/user_local_prefs/user_local_prefs_bloc.dart';
import 'package:blavapp/components/images/app_network_image.dart';
import 'package:blavapp/constants/icons.dart';
import 'package:blavapp/model/catering.dart';
import 'package:blavapp/utils/app_heros.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:blavapp/utils/pref_interpreter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// TODO: make this structure more readable

class MealItemCard extends StatelessWidget {
  final MealItem item;
  const MealItemCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, CaterPlace> places =
        BlocProvider.of<CateringBloc>(context).state.cateringPlaces;
    return Card(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              t(item.name, context),
                              style: Theme.of(context).textTheme.headline6,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (!item.images.isNotEmpty)
                              _CateringAttIcons(item: item)
                          ],
                        ),
                        const SizedBox(height: 8),
                        Column(
                          children: [
                            _buildInfoLine(
                              Icons.category_outlined,
                              tCaterItemType(item.type, context),
                            ),
                            if (item.allergens.isNotEmpty)
                              _buildInfoLine(
                                Icons.warning,
                                item.allergens.toString(),
                              ),
                            if (item.placeRef.isNotEmpty) ...[
                              const Divider(),
                              for (String placeRef in item.placeRef)
                                _buildInfoLine(
                                  Icons.place_outlined,
                                  places.containsKey(placeRef)
                                      ? t(places[placeRef]!.name, context)
                                      : '?$placeRef?',
                                ),
                            ],
                          ],
                        ),
                        const Divider(),
                        if (item.desc != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            t(item.desc!, context),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                if (item.images.isNotEmpty)
                  Expanded(
                    flex: 1,
                    child: Stack(children: [
                      _CateringItemHeroImage(item: item),
                      Positioned(
                        top: 2,
                        right: 2,
                        child: _CateringAttIcons(item: item),
                      ),
                    ]),
                  ),
              ],
            ),
          ),
          const Divider(),
          _CaterPriceWrap(item: item),
        ],
      ),
    );
  }

  Widget _buildInfoLine(IconData iconData, String text) {
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

class _CateringAttIcons extends StatelessWidget {
  const _CateringAttIcons({
    Key? key,
    required this.item,
  }) : super(key: key);

  final MealItem item;

  @override
  Widget build(BuildContext context) {
    if (item.vegetarian || item.vegan || item.glutenFree) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
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
        ),
      );
    } else {
      return Container();
    }
  }
}

class _CateringItemHeroImage extends StatelessWidget {
  const _CateringItemHeroImage({
    Key? key,
    required this.item,
  }) : super(key: key);

  final MealItem item;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: caterMealItemImgHeroTag(item),
      child: AppNetworkImage(
        url: item.images[0],
        asCover: true,
      ),
    );
  }
}

class _CaterPriceWrap extends StatelessWidget {
  const _CaterPriceWrap({
    Key? key,
    required this.item,
  }) : super(key: key);

  final MealItem item;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.end,
      children: item.volumes
          .map((CaterVolume e) => _CaterPriceVolume(pv: e))
          .toList(),
    );
  }
}

class _CaterPriceVolume extends StatelessWidget {
  final CaterVolume pv;
  const _CaterPriceVolume({
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
                style: Theme.of(context).textTheme.headline6,
              );
            },
          ),
          if (pv.desc != null) Text(t(pv.desc!, context)),
        ],
      ),
    );
  }
}
