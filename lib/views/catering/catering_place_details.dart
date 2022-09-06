import 'package:blavapp/bloc/catering/data_catering/catering_bloc.dart';
import 'package:blavapp/bloc/catering/place_menu/place_menu_catering_bloc.dart';
import 'package:blavapp/bloc/user_data/user_local_prefs/user_local_prefs_bloc.dart';
import 'package:blavapp/components/images/app_network_image.dart';
import 'package:blavapp/components/pages/page_side.dart';
import 'package:blavapp/components/views/title_divider.dart';
import 'package:blavapp/model/catering.dart';
import 'package:blavapp/utils/app_heros.dart';
import 'package:blavapp/utils/model_helper.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:blavapp/utils/pref_interpreter.dart';
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
    return BlocProvider(
      create: (context) => PlaceMenuCateringBloc(
        catering: context.read<CateringBloc>().state.catering,
        placeRef: place.id,
      ),
      child: SidePage(
        // titleText: t(place.name, context),
        titleText: AppLocalizations.of(context)!.contCateringDetailPlaceTitle,
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              if (place.images.isNotEmpty)
                _CateringPlaceHeroImage(place: place),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    BlocBuilder<PlaceMenuCateringBloc, PlaceMenuCateringState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        _PlaceTitle(place: place),
                        if (place.open != null)
                          _CateringPlaceOpenInfo(place: place),
                        if (state.hasMeals) ...[
                          _MealPlaceMenu(
                            place: place,
                            mealSections: state.mealSections,
                          ),
                          const SizedBox(height: 16),
                        ],
                        if (state.hasBeverages)
                          _BeveragePlaceMenu(place: place),
                        const SizedBox(height: 32),
                      ],
                    );
                  },
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

  final CaterPlace place;

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

class _MealPlaceMenu extends StatelessWidget {
  final CaterPlace place;
  final List<MenuMealSec> mealSections;

  const _MealPlaceMenu({
    Key? key,
    required this.place,
    required this.mealSections,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        TitleDivider(
          title: AppLocalizations.of(context)!.contCateringPlaceDetailsMenu,
        ),
        const SizedBox(height: 16),
        Column(
          children: mealSections.map((MenuMealSec section) {
            return section.items.isNotEmpty
                ? _MealMenuSection(section: section)
                : Container();
          }).toList(),
        ),
      ],
    );
  }
}

class _MealMenuSection extends StatelessWidget {
  final MenuMealSec section;
  const _MealMenuSection({
    Key? key,
    required this.section,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserCurrencyPref curPref =
        BlocProvider.of<UserLocalPrefsBloc>(context).state.currency;
    return Column(
      children: [
        const SizedBox(height: 8),
        Text(
          tMealItemType(section.type, context),
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 4),
        ...section.items.map((MealItem item) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    t(item.name, context),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: item.volumes
                        .map(
                          (pv) => Text(
                            '${prefCurrency(curPref, pv.price, context)}  ${pv.desc != null ? '/${t(pv.desc!, context)}' : ''}',
                            textAlign: TextAlign.end,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

class _BeveragePlaceMenu extends StatelessWidget {
  final CaterPlace place;

  const _BeveragePlaceMenu({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        TitleDivider(
          title: AppLocalizations.of(context)!.contCateringPlaceDetailsBeverage,
        ),
        const SizedBox(height: 16),
        BlocBuilder<PlaceMenuCateringBloc, PlaceMenuCateringState>(
          builder: (context, state) {
            return Column(
              children: state.beverageSections.map((MenuBeverageSec section) {
                return section.items.isNotEmpty
                    ? __BeverageMenuSection(section: section)
                    : Container();
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}

class __BeverageMenuSection extends StatelessWidget {
  final MenuBeverageSec section;
  const __BeverageMenuSection({
    Key? key,
    required this.section,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserCurrencyPref curPref =
        BlocProvider.of<UserLocalPrefsBloc>(context).state.currency;
    return Column(
      children: [
        const SizedBox(height: 8),
        Text(
          tBeverageItemType(section.type, context),
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 4),
        ...section.items.map((BeverageItem item) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    t(item.name, context),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: item.volumes
                        .map(
                          (pv) => Text(
                            '${prefCurrency(curPref, pv.price, context)}  ${pv.desc != null ? '/${t(pv.desc!, context)}' : ''}',
                            textAlign: TextAlign.end,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
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
