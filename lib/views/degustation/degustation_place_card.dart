import 'package:blavapp/bloc/degustation/place_degustation/place_degustation_bloc.dart';
import 'package:blavapp/bloc/user_data/user_local_prefs/user_local_prefs_bloc.dart';
import 'package:blavapp/components/images/app_network_image.dart';
import 'package:blavapp/model/degustation.dart';
import 'package:blavapp/utils/app_heros.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:blavapp/utils/pref_implementation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DegustationPlaceCard extends StatelessWidget {
  final DegustationPlaceInfo degustationPlaceInfo;
  const DegustationPlaceCard({
    Key? key,
    required this.degustationPlaceInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              t(degustationPlaceInfo.place.name, context),
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline5,
            ),
            const Divider(),
            Row(
              children: [
                if (degustationPlaceInfo.place.opens != null)
                  Expanded(
                    flex: 1,
                    child: _DegustationPlaceOpenHours(
                      place: degustationPlaceInfo.place,
                    ),
                  ),
                if (degustationPlaceInfo.place.images.isNotEmpty)
                  Expanded(
                    flex: 1,
                    child: _DegustationPlaceHeroImage(
                      place: degustationPlaceInfo.place,
                    ),
                  ),
              ],
            ),
            const Divider(),
            Expanded(
              child: _DegustationPlaceMenu(
                menu: degustationPlaceInfo.items,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DegustationPlaceOpenHours extends StatelessWidget {
  final DegusPlace place;
  const _DegustationPlaceOpenHours({Key? key, required this.place})
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
                      .degusPlaceCardOpensAt(place.opens!['from'] ?? '??'),
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!
                      .degusPlaceCardClosesAt(place.opens!['to'] ?? '??'),
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

class _DegustationPlaceHeroImage extends StatelessWidget {
  final DegusPlace place;

  const _DegustationPlaceHeroImage({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: degusItemPlaceHeroTag(place),
      child: AppNetworkImage(
        imgLocation: place.images[0],
        asCover: true,
      ),
    );
  }
}

class _DegustationPlaceMenu extends StatelessWidget {
  final List<DegustationPlaceMenuSec> menu;
  const _DegustationPlaceMenu({
    Key? key,
    required this.menu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: menu
            .map(
              (DegustationPlaceMenuSec sec) => sec.items.isNotEmpty
                  ? Column(
                      children: [
                        // Section name
                        Text(
                          tDegusAlcoholType(sec.type, context),
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
