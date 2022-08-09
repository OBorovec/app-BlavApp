import 'package:blavapp/bloc/catering/places_catering/places_catering_bloc.dart';
import 'package:blavapp/bloc/user_data/user_local_prefs/user_local_prefs_bloc.dart';
import 'package:blavapp/components/images/app_network_image.dart';
import 'package:blavapp/model/catering.dart';
import 'package:blavapp/utils/app_heros.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:blavapp/utils/pref_interpreter.dart';
import 'package:blavapp/views/catering/catering_widgets.dart';
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
                if (cateringPlaceInfo.place.open != null)
                  Expanded(
                    flex: 2,
                    child: _CateringPlaceOpenHours(
                      place: cateringPlaceInfo.place,
                      isOpen: cateringPlaceInfo.isOpen,
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
  final bool isOpen;
  const _CateringPlaceOpenHours({
    Key? key,
    required this.place,
    required this.isOpen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String openFrom = place.open!['from']!;
    final String openTo = place.open!['to']!;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.watch_later_outlined),
              const SizedBox(width: 8),
              Text(
                isOpen
                    ? AppLocalizations.of(context)!.caterPlaceCardIsOpen
                    : AppLocalizations.of(context)!.caterPlaceCardIsClosed,
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ],
          ),
          Text(
            '$openFrom - $openTo',
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      ),
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
        asCover: false,
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
                              .map(
                                (item) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    children: [
                                      // Item info
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              t(item.name, context),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                            ),
                                            CateringAttIcons(
                                              item: item,
                                              size: 16,
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Item volumes
                                      Expanded(
                                        flex: 1,
                                        child: BlocBuilder<UserLocalPrefsBloc,
                                            UserLocalPrefsState>(
                                          builder: (context, state) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: item.volumes
                                                  .map(
                                                    (pv) => Text(
                                                      '${prefCurrency(state.currency, pv.price, context)} / ${t(pv.desc, context)}',
                                                      textAlign: TextAlign.end,
                                                    ),
                                                  )
                                                  .toList(),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
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
