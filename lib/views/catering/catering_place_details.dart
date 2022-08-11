import 'package:blavapp/bloc/catering/data_catering/catering_bloc.dart';
import 'package:blavapp/bloc/catering/place_menu/place_menu_catering_bloc.dart';
import 'package:blavapp/bloc/user_data/user_local_prefs/user_local_prefs_bloc.dart';
import 'package:blavapp/components/images/app_network_image.dart';
import 'package:blavapp/components/page_hierarchy/side_page.dart';
import 'package:blavapp/components/views/title_divider.dart';
import 'package:blavapp/model/catering.dart';
import 'package:blavapp/utils/app_heros.dart';
import 'package:blavapp/utils/model_helper.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:blavapp/utils/pref_interpreter.dart';
import 'package:blavapp/views/catering/catering_widgets.dart';
import 'package:blavapp/views/maps/maps_control_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CateringPlaceDetails extends StatelessWidget {
  final CaterPlace place;
  const CateringPlaceDetails({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SidePage(
      titleText: t(place.name, context),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            if (place.images.isNotEmpty) _CateringPlaceHeroImage(place: place),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (place.open != null) _CateringPlaceOpenInfo(place: place),
                  _CateringPlaceMenu(place: place),
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

class _CateringPlaceHeroImage extends StatelessWidget {
  final CaterPlace place;

  const _CateringPlaceHeroImage({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.4,
      child: Hero(
        tag: caterItemPlaceHeroTag(place),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(64),
          ),
          child: AppNetworkImage(
            imgLocation: place.images[0],
            asCover: true,
          ),
        ),
      ),
    );
  }
}

class _CateringPlaceOpenInfo extends StatelessWidget {
  final CaterPlace place;

  const _CateringPlaceOpenInfo({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String openFrom = place.open!['from']!;
    final String openTo = place.open!['to']!;
    final bool isOpen = isOpenCal(place.open!);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
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

class _CateringPlaceMenu extends StatelessWidget {
  final CaterPlace place;

  const _CateringPlaceMenu({
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
          create: (context) => PlaceMenuCateringBloc(
            catering: context.read<CateringBloc>().state.catering,
            placeRef: place.id,
          ),
          child: BlocBuilder<PlaceMenuCateringBloc, PlaceMenuCateringState>(
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
          tCaterItemType(section.type, context),
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subtitle2,
        ),
        ...section.items.map((CaterItem item) {
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
                    CateringAttIcons(
                      item: item,
                      size: 16,
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

class CateringPlaceDetailsArguments {
  final CaterPlace place;

  CateringPlaceDetailsArguments({required this.place});
}
