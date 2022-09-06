import 'package:blavapp/bloc/degustation/data_degustation/degustation_bloc.dart';
import 'package:blavapp/bloc/degustation/place_degus_menu/place_menu_degustation_bloc.dart';
import 'package:blavapp/bloc/user_data/user_local_prefs/user_local_prefs_bloc.dart';
import 'package:blavapp/components/images/app_network_image.dart';
import 'package:blavapp/components/pages/page_side.dart';
import 'package:blavapp/components/views/title_divider.dart';
import 'package:blavapp/model/degustation.dart';
import 'package:blavapp/utils/app_heros.dart';
import 'package:blavapp/utils/model_helper.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:blavapp/utils/pref_interpreter.dart';
import 'package:blavapp/views/maps/maps_control_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DegustationPlaceDetails extends StatelessWidget {
  final DegusPlace place;
  const DegustationPlaceDetails({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SidePage(
      // titleText: t(place.name, context),
      titleText: AppLocalizations.of(context)!.contDegustationDetailPlaceTitle,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            if (place.images.isNotEmpty)
              _DegustationPlaceHeroImage(place: place),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _PlaceTitle(place: place),
                  if (place.open != null)
                    _DegustationPlaceOpenInfo(place: place),
                  _DegustationPlaceMenu(place: place),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        if (place.loc != null)
          IconBtnPushCustomMap(
            mapRef: place.loc!.mapRef,
            pointRef: place.loc!.pointRef,
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
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.4,
      child: Hero(
        tag: degusItemPlaceHeroTag(place),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(64),
          ),
          child: AppNetworkImage(
            url: place.images[0],
            asCover: true,
          ),
        ),
      ),
    );
  }
}

class _PlaceTitle extends StatelessWidget {
  const _PlaceTitle({
    Key? key,
    required this.place,
  }) : super(key: key);

  final DegusPlace place;

  @override
  Widget build(BuildContext context) {
    return Text(
      t(place.name, context),
      style: Theme.of(context).textTheme.headline5,
      maxLines: 2,
      overflow: TextOverflow.clip,
      textAlign: TextAlign.center,
    );
  }
}

class _DegustationPlaceOpenInfo extends StatelessWidget {
  final DegusPlace place;

  const _DegustationPlaceOpenInfo({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String openFrom = place.open!['from']!;
    final String openTo = place.open!['to']!;
    final bool isOpen = isOpenCal(place.open!);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.watch_later_outlined),
            const SizedBox(width: 8),
            Text(
              isOpen
                  ? AppLocalizations.of(context)!.genOpen
                  : AppLocalizations.of(context)!.genClose,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
        Text(
          '$openFrom - $openTo',
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ],
    );
  }
}

class _DegustationPlaceMenu extends StatelessWidget {
  final DegusPlace place;

  const _DegustationPlaceMenu({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        TitleDivider(
          title: AppLocalizations.of(context)!.contCateringPlaceDetailsMenu,
        ),
        BlocProvider(
          create: (context) => PlaceMenuDegustationBloc(
            degustation: context.read<DegustationBloc>().state.degustation,
            placeRef: place.id,
          ),
          child:
              BlocBuilder<PlaceMenuDegustationBloc, PlaceMenuDegustationState>(
            builder: (context, state) {
              return Column(
                children: state.sections.map((MenuSec section) {
                  return section.items.isNotEmpty
                      ? _MenuSection(section: section)
                      : Container();
                }).toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _MenuSection extends StatelessWidget {
  final MenuSec section;
  const _MenuSection({
    Key? key,
    required this.section,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          tDegusAlcoholType(section.type, context),
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subtitle2,
        ),
        ...section.items.map((DegusItem item) {
          return Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t(item.name, context),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: BlocBuilder<UserLocalPrefsBloc, UserLocalPrefsState>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
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
          );
        }),
      ],
    );
  }
}

class DegustationPlaceDetailsArguments {
  final DegusPlace place;

  DegustationPlaceDetailsArguments({required this.place});
}
