import 'package:blavapp/bloc/catering/places_catering/places_catering_bloc.dart';
import 'package:blavapp/bloc/user_data/user_local_prefs/user_local_prefs_bloc.dart';
import 'package:blavapp/components/images/app_network_image.dart';
import 'package:blavapp/constants/icons.dart';
import 'package:blavapp/model/catering.dart';
import 'package:blavapp/route_generator.dart';
import 'package:blavapp/utils/app_heros.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:blavapp/utils/pref_interpreter.dart';
import 'package:blavapp/views/maps/map_view_page.dart';
import 'package:blavapp/views/maps/maps_control_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CateringPlaceCard extends StatelessWidget {
  final CateringPlaceInfo cateringPlaceInfo;
  const CateringPlaceCard({
    Key? key,
    required this.cateringPlaceInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  t(cateringPlaceInfo.place.name, context),
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline5,
                ),
                if (cateringPlaceInfo.place.loc != null)
                  IconBtnPushCustomMap(
                    mapRef: cateringPlaceInfo.place.loc!.mapRef,
                    pointRef: cateringPlaceInfo.place.loc!.pointRef,
                  ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                if (cateringPlaceInfo.place.opens != null)
                  Expanded(
                    flex: 1,
                    child: _CateringPlaceOpenHours(
                      place: cateringPlaceInfo.place,
                    ),
                  ),
                if (cateringPlaceInfo.place.images.isNotEmpty)
                  Expanded(
                    flex: 1,
                    child: _CateringPlaceHeroImage(
                      place: cateringPlaceInfo.place,
                    ),
                  ),
              ],
            ),
            const Divider(),
            Expanded(
              child: _CateringPlaceMenu(
                menu: cateringPlaceInfo.items,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CateringPlaceOpenHours extends StatelessWidget {
  final CaterPlace place;
  const _CateringPlaceOpenHours({Key? key, required this.place})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // TODO: Add icons for being closed or open
        Expanded(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!
                      .caterPlaceCardOpensAt(place.opens!['from'] ?? '??'),
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!
                      .caterPlaceCardClosesAt(place.opens!['to'] ?? '??'),
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CateringPlaceHeroImage extends StatelessWidget {
  final CaterPlace place;

  const _CateringPlaceHeroImage({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: caterItemPlaceHeroTag(place),
      child: AppNetworkImage(
        imgLocation: place.images[0],
        asCover: true,
      ),
    );
  }
}

class _CateringPlaceMenu extends StatelessWidget {
  final List<CateringPlaceMenuSec> menu;
  const _CateringPlaceMenu({
    Key? key,
    required this.menu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: menu
            .map(
              (CateringPlaceMenuSec sec) => sec.items.isNotEmpty
                  ? Column(
                      children: [
                        // Section name
                        Text(
                          tCaterItemType(sec.type, context),
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        // Section items
                        Column(
                          children: sec.items
                              .map((item) => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Item info
                                      Row(
                                        children: [
                                          Text(
                                            t(item.name, context),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          if (item.vegetarian)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 4.0),
                                              child: ImageIcon(
                                                AppIcons.vegetarian,
                                                size: 16,
                                              ),
                                            ),
                                          if (item.vegan)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 4.0),
                                              child: ImageIcon(
                                                AppIcons.vegan,
                                                size: 16,
                                              ),
                                            ),
                                          if (item.glutenFree)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 4.0),
                                              child: ImageIcon(
                                                AppIcons.glutenFree,
                                                size: 16,
                                              ),
                                            ),
                                        ],
                                      ),
                                      // Item volumes
                                      BlocBuilder<UserLocalPrefsBloc,
                                          UserLocalPrefsState>(
                                        builder: (context, state) {
                                          return Column(
                                            children: item.volumes
                                                .map((pv) => Text(
                                                    '${prefCurrency(state.currency, pv.price, context)} / ${t(pv.desc, context)}'))
                                                .toList(),
                                          );
                                        },
                                      )
                                    ],
                                  ))
                              .toList(),
                        ),
                      ],
                    )
                  : Container(),
            )
            .toList(),
      ),
    );
  }
}
