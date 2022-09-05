import 'package:blavapp/bloc/catering/highlight_catering/highlight_catering_bloc.dart';
import 'package:blavapp/components/views/title_divider.dart';
import 'package:blavapp/route_generator.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:blavapp/views/catering/catering_place_details.dart';
import 'package:blavapp/views/maps/maps_control_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CateringOverview extends StatelessWidget {
  const CateringOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HighlightCateringBloc, HighlightCateringState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  if (state.headerText != null)
                    Expanded(
                      child: _CateringHeader(state: state),
                    ),
                  // TODO: come up with a better stats
                  // Expanded(
                  //   child: _CateringNumbers(state: state),
                  // ),
                ],
              ),
              _CateringPlaceList(state: state),
            ],
          ),
        );
      },
    );
  }
}

class _CateringHeader extends StatelessWidget {
  final HighlightCateringState state;

  const _CateringHeader({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        left: 8.0,
      ),
      child: Text(
        t(state.headerText!, context),
        maxLines: 10,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _CateringNumbers extends StatelessWidget {
  final HighlightCateringState state;

  const _CateringNumbers({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildLine(
              AppLocalizations.of(context)!.contCateringHighlightTotalItems,
              state.totalItems,
              context,
            ),
            const SizedBox(height: 8),
            _buildLine(
              AppLocalizations.of(context)!.contCateringHighlightTotalPlaces,
              state.totalPlaces,
              context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLine(String text, int number, BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 2, child: Text(text)),
          Expanded(
            flex: 1,
            child: Text(
              number.toString(),
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ],
      );
}

class _CateringPlaceList extends StatelessWidget {
  final HighlightCateringState state;

  const _CateringPlaceList({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        TitleDivider(
          title: AppLocalizations.of(context)!.contCateringHighlightPlaceList,
        ),
        const SizedBox(height: 8),
        Column(
          children: state.placeCardData
              .map((HighlightPlaceCardData data) => _CateringHighlightPlaceCard(
                    data: data,
                    onTap: () => Navigator.pushNamed(
                      context,
                      RoutePaths.cateringPlace,
                      arguments: CateringPlaceDetailsArguments(
                        place: data.place,
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class _CateringHighlightPlaceCard extends StatelessWidget {
  final HighlightPlaceCardData data;
  final Function() onTap;

  const _CateringHighlightPlaceCard({
    Key? key,
    required this.data,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IntrinsicHeight(
            child: Row(
              children: [
                if (data.place.loc != null)
                  IconBtnPushCustomMap(
                    mapRef: data.place.loc!.mapRef,
                    pointRef: data.place.loc!.pointRef,
                  ),
                const VerticalDivider(),
                Expanded(
                  flex: 2,
                  child: Text(
                    t(data.place.name, context),
                    style: Theme.of(context).textTheme.subtitle1,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (data.place.open != null) _buildOpeningIndicator(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded _buildOpeningIndicator(BuildContext context) {
    final String openFrom = data.place.open!['from']!;
    final String openTo = data.place.open!['to']!;
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.watch_later_outlined,
                size: 12,
              ),
              const SizedBox(width: 8),
              Text(
                data.isOpen
                    ? AppLocalizations.of(context)!.genOpen
                    : AppLocalizations.of(context)!.genClose,
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
