import 'package:blavapp/bloc/degustation/highlight_degustation/highlight_degustation_bloc.dart';
import 'package:blavapp/components/views/rating_indicator.dart';
import 'package:blavapp/components/views/title_divider.dart';
import 'package:blavapp/model/degustation.dart';
import 'package:blavapp/route_generator.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:blavapp/views/degustation/degustation_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DegustationHighlight extends StatelessWidget {
  const DegustationHighlight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HighlightDegustationBloc>(context)
        .add(const UpdateViewData());
    return BlocBuilder<HighlightDegustationBloc, HighlightDegustationState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  if (state.headerText != null)
                    Expanded(
                      child: _DegustationHeader(state: state),
                    ),
                  Expanded(
                    child: _DegustaionNumbers(state: state),
                  ),
                ],
              ),
              _DegustationHighlightBestRated(state: state),
              if (state.recommendations.isNotEmpty)
                _DegustationHighlightRecommendation(state: state),
              if (state.similarToLiked.isNotEmpty)
                _DegustationHighlightSimilarToLiked(state: state),
            ],
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
              AppLocalizations.of(context)!.degusHighlightTotalSample,
              state.totalSamples,
              context,
            ),
            const SizedBox(height: 8),
            _buildLine(
              AppLocalizations.of(context)!.degusHighlightLiked,
              state.totalFavorites,
              context,
            ),
            const SizedBox(height: 8),
            _buildLine(
              AppLocalizations.of(context)!.degusHighlightRated,
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
              tDegusAlcoholType(item.alcoholType, context),
            ),
            if (item.subType != null)
              Text(
                tDegusSubAlcoholType(item.subType!, context),
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
          title: AppLocalizations.of(context)!.degusHighlightBestRated,
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
          title: AppLocalizations.of(context)!.degusHighlightRecommendation,
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
          title: AppLocalizations.of(context)!.degusHighlightSimilarTo,
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
