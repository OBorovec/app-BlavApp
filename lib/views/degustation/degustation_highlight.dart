import 'package:blavapp/bloc/degustation/data_degustation/degustation_bloc.dart';
import 'package:blavapp/bloc/degustation/highlight_degustation/highlight_degustation_bloc.dart';
import 'package:blavapp/components/views/collapsable_text_section.dart';
import 'package:blavapp/components/views/rating_indicator.dart';
import 'package:blavapp/components/views/title_divider.dart';
import 'package:blavapp/model/common.dart';
import 'package:blavapp/model/degustation.dart';
import 'package:blavapp/route_generator.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:blavapp/views/degustation/degustation_details.dart';
import 'package:blavapp/views/degustation/degustation_place_details.dart';
import 'package:blavapp/views/maps/maps_control_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DegustationHighlight extends StatefulWidget {
  const DegustationHighlight({Key? key}) : super(key: key);

  @override
  State<DegustationHighlight> createState() => _DegustationHighlightState();
}

class _DegustationHighlightState extends State<DegustationHighlight> {
  List<bool> showFullExtrasText = [];
  @override
  Widget build(BuildContext context) {
    List<Extras> extras =
        BlocProvider.of<DegustationBloc>(context).state.degustation.extras;
    if (showFullExtrasText.isEmpty) {
      showFullExtrasText = List<bool>.filled(
        extras.length,
        false,
      );
    }
    return BlocBuilder<HighlightDegustationBloc, HighlightDegustationState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    if (state.headerText != null)
                      Expanded(
                        child: _DegustationHeader(state: state),
                      ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _DegustaionNumbers(state: state),
                    ),
                  ],
                ),
                _DegustationPlaceList(state: state),
                _DegustationHighlightBestRated(state: state),
                if (state.recommendations.isNotEmpty)
                  _DegustationHighlightRecommendation(state: state),
                if (state.similarToLiked.isNotEmpty)
                  _DegustationHighlightSimilarToLiked(state: state),
                const SizedBox(height: 8),
                ...extras.map(
                  (Extras e) {
                    int index = extras.indexOf(e);
                    return CollapsableTextSection(
                      title: t(e.title, context),
                      body: t(e.body, context),
                      isExpanded: showFullExtrasText[index],
                      onToggle: () => setState(() {
                        showFullExtrasText[index] = !showFullExtrasText[index];
                      }),
                    );
                  },
                ).toList(),
                const SizedBox(height: 64),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DegustationHeader extends StatelessWidget {
  final HighlightDegustationState state;

  const _DegustationHeader({
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
        maxLines: 12,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _DegustaionNumbers extends StatelessWidget {
  final HighlightDegustationState state;

  const _DegustaionNumbers({
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
              AppLocalizations.of(context)!.contDegustationHighlightTotalSample,
              state.totalSamples,
              context,
            ),
            const SizedBox(height: 8),
            _buildLine(
              AppLocalizations.of(context)!.contDegustationHighlightLiked,
              state.totalFavorites,
              context,
            ),
            const SizedBox(height: 8),
            _buildLine(
              AppLocalizations.of(context)!.contDegustationHighlightRated,
              state.totalRated,
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

class _DegustationPlaceList extends StatelessWidget {
  final HighlightDegustationState state;

  const _DegustationPlaceList({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        TitleDivider(
          title:
              AppLocalizations.of(context)!.contDegustationHighlightPlaceList,
        ),
        Column(
          children: state.placeCardData
              .map((HighlightPlaceCardData data) =>
                  _DegustationHighlightPlaceCard(
                    data: data,
                    onTap: () => Navigator.pushNamed(
                      context,
                      RoutePaths.degustationPlace,
                      arguments: DegustationPlaceDetailsArguments(
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

class _DegustationHighlightPlaceCard extends StatelessWidget {
  final HighlightPlaceCardData data;
  final Function() onTap;

  const _DegustationHighlightPlaceCard({
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

class _DegustationItemHighlightCard extends StatelessWidget {
  final DegusItem item;

  const _DegustationItemHighlightCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              t(item.name, context),
              style: Theme.of(context).textTheme.subtitle1,
            ),
            AppRatingIndicator(
              rating: item.rating,
              itemSize: 16,
            ),
            Text(
              tDegusAlcoholType(item.type, context),
            ),
            if (item.subType != null)
              Text(
                t(item.subType!, context),
              ),
          ],
        ),
      ),
    );
  }
}

class _DegustationHighlightBestRated extends StatelessWidget {
  final HighlightDegustationState state;

  const _DegustationHighlightBestRated({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        TitleDivider(
          title:
              AppLocalizations.of(context)!.contDegustationHighlightBestRated,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: state.bestRated
                .map(
                  (DegusItem item) => InkWell(
                    onTap: () => Navigator.pushNamed(
                      context,
                      RoutePaths.degustationItem,
                      arguments: DegustationDetailsArguments(
                        item: item,
                      ),
                    ),
                    child: _DegustationItemHighlightCard(item: item),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _DegustationHighlightRecommendation extends StatelessWidget {
  final HighlightDegustationState state;

  const _DegustationHighlightRecommendation({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        TitleDivider(
          title: AppLocalizations.of(context)!
              .contDegustationHighlightRecommendation,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: state.recommendations
                .map(
                  (DegusItem item) => InkWell(
                    onTap: () => Navigator.pushNamed(
                      context,
                      RoutePaths.degustationItem,
                      arguments: DegustationDetailsArguments(
                        item: item,
                      ),
                    ),
                    child: _DegustationItemHighlightCard(item: item),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _DegustationHighlightSimilarToLiked extends StatelessWidget {
  final HighlightDegustationState state;

  const _DegustationHighlightSimilarToLiked({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        TitleDivider(
          title:
              AppLocalizations.of(context)!.contDegustationHighlightSimilarTo,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: state.similarToLiked
                .map(
                  (DegusItem item) => InkWell(
                    onTap: () => Navigator.pushNamed(
                      context,
                      RoutePaths.degustationItem,
                      arguments: DegustationDetailsArguments(
                        item: item,
                      ),
                    ),
                    child: _DegustationItemHighlightCard(item: item),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
