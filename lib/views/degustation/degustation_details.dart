import 'package:blavapp/bloc/degustation/data_degustation/degustation_bloc.dart';
import 'package:blavapp/bloc/user_data/user_data/user_data_bloc.dart';
import 'package:blavapp/components/control/rating_bar.dart';
import 'package:blavapp/components/images/app_network_image.dart';
import 'package:blavapp/components/page_hierarchy/side_page.dart';
import 'package:blavapp/components/views/rating_indicator.dart';
import 'package:blavapp/components/views/title_divider.dart';
import 'package:blavapp/model/degustation.dart';
import 'package:blavapp/route_generator.dart';
import 'package:blavapp/utils/app_heros.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:blavapp/views/degustation/degustation_bloc_widgets.dart';
import 'package:blavapp/views/degustation/degustation_place_details.dart';
import 'package:blavapp/views/maps/map_view_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DegustationDetails extends StatelessWidget {
  final DegusItem item;
  const DegustationDetails({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SidePage(
      titleText: t(item.name, context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (item.images.isNotEmpty) _DegustationItemHeroImage(item: item),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (item.desc != null) ...[
                    _DegustationItemDescription(item: item),
                  ],
                  _DegustationItemPlaces(item: item),
                  _DegustationItemRating(item: item),
                  const SizedBox(height: 8),
                  const Divider(),
                  const SizedBox(height: 8),
                  _DegustationItemControlBtns(item: item),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        DegustationFavoriteSwitch(itemRef: item.id),
      ],
    );
  }
}

class _DegustationItemHeroImage extends StatelessWidget {
  final DegusItem item;

  const _DegustationItemHeroImage({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.4,
      child: Hero(
        tag: degusItemImgHeroTag(item),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(64),
          ),
          child: AppNetworkImage(
            imgLocation: item.images[0],
            asCover: true,
          ),
        ),
      ),
    );
  }
}

class _DegustationItemDescription extends StatelessWidget {
  final DegusItem item;

  const _DegustationItemDescription({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        TitleDivider(
          title: AppLocalizations.of(context)!.description,
        ),
        Text(t(item.desc!, context))
      ],
    );
  }
}

class _DegustationItemPlaces extends StatelessWidget {
  final DegusItem item;

  const _DegustationItemPlaces({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        TitleDivider(
          title: AppLocalizations.of(context)!.degusDetailWhereToBuy,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: item.placeRef.map(
              (String placeRef) {
                if (!context
                    .read<DegustationBloc>()
                    .state
                    .degustationPlaces
                    .containsKey(placeRef)) return Container();
                DegusPlace place = context
                    .read<DegustationBloc>()
                    .state
                    .degustationPlaces[placeRef]!;
                return InkWell(
                  onTap: () => Navigator.pushNamed(
                    context,
                    RoutePaths.degustationPlace,
                    arguments: DegustationPlaceDetailsArguments(
                      place: place,
                    ),
                  ),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8,
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            Text(
                              t(place.name, context),
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            const VerticalDivider(),
                            IconButton(
                              onPressed: () => Navigator.pushNamed(
                                context,
                                RoutePaths.mapView,
                                arguments: MapViewArguments(
                                  mapRef: place.loc!.mapRef,
                                  pointRefZoom: place.loc!.pointRef,
                                ),
                              ),
                              icon: const Icon(Icons.location_on),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}

class _DegustationItemRating extends StatelessWidget {
  final DegusItem item;

  const _DegustationItemRating({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        TitleDivider(
          title: AppLocalizations.of(context)!.degusDetailRating,
        ),
        IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: item.rating != null
                      ? AppRatingIndicator(
                          rating: item.rating!,
                          itemSize: 32,
                        )
                      : Text(
                          AppLocalizations.of(context)!.degusDetailNoRating,
                          style: Theme.of(context).textTheme.subtitle1,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                ),
              ),
              if (item.rating != null)
                Text(
                  '(${item.rating})',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              const VerticalDivider(),
              BlocBuilder<UserDataBloc, UserDataState>(
                builder: (context, state) {
                  if (state.userData.myRatings.containsKey(item.id)) {
                    return InkWell(
                      onLongPress: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => _buildRatingDialog(
                            context,
                            AppLocalizations.of(context)!
                                .degusDetailReRateMeTitle),
                      ),
                      child: Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.degusDetailYourRating,
                            style: Theme.of(context).textTheme.subtitle2,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            state.userData.myRatings[item.id].toString(),
                            style: Theme.of(context).textTheme.subtitle1,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  } else {
                    return ElevatedButton(
                      onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => _buildRatingDialog(
                            context,
                            AppLocalizations.of(context)!
                                .degusDetailRateMeTitle),
                      ),
                      child: Text(
                          AppLocalizations.of(context)!.degusDetailBtnRateMe),
                    );
                  }
                },
              ),
            ],
          ),
        )
      ],
    );
  }

  AlertDialog _buildRatingDialog(BuildContext context, String titleText) {
    return AlertDialog(
      title: Text(
        titleText,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AppRatingBar(
            onRating: ((rating) {
              BlocProvider.of<UserDataBloc>(context).add(
                UserDataRateItem(
                  itemRef: item.id,
                  rating: rating,
                ),
              );
              Navigator.pop(context);
            }),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppLocalizations.of(context)!.dismiss),
        ),
      ],
    );
  }
}

class _DegustationItemControlBtns extends StatelessWidget {
  final DegusItem item;

  const _DegustationItemControlBtns({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () => null,
          icon: const Icon(Icons.store),
          label: Text(AppLocalizations.of(context)!.degusDetailBtnShop),
        )
      ],
    );
  }
}

class DegustationDetailsArguments {
  final DegusItem item;

  DegustationDetailsArguments({required this.item});
}