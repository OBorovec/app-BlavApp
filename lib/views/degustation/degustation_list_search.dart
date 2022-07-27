import 'package:blavapp/bloc/degustation/filter_degustation/filter_degustation_bloc.dart';
import 'package:blavapp/components/control/button_switch.dart';
import 'package:blavapp/model/catering.dart';
import 'package:blavapp/model/degustation.dart';
import 'package:blavapp/utils/app_themes.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DegustationSearchTile extends StatelessWidget {
  const DegustationSearchTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterDegustationBloc, FilterDegustationState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              children: [
                const Expanded(child: _TextSearchLine()),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () => _showSearchOptions(context, state),
                  iconSize: 48,
                ),
              ],
            ),
            const SizedBox(height: 4),
            _buildActiveSearchTagWrap(state, context),
          ],
        );
      },
    );
  }

  Future<dynamic> _showSearchOptions(
    BuildContext context,
    FilterDegustationState state,
  ) {
    return showModalBottomSheet(
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: BlocProvider.of<FilterDegustationBloc>(context),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.degusSearchPredef,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 8),
                  _buildFilterSubtitle(
                    context,
                    AppLocalizations.of(context)!.degusSearchTypes,
                    Icons.access_time_outlined,
                  ),
                  Wrap(
                    children: state.availableAlcoholTypes
                        .map((e) => _DegustationAlcTypeSearchTag(type: e))
                        .toList(),
                  ),
                  _buildFilterSubtitle(
                    context,
                    AppLocalizations.of(context)!.degusSearchOrigin,
                    Icons.place_outlined,
                  ),
                  Wrap(
                    children: state.availableOrigins
                        .map((e) => _DegustationOriginSearchTag(origin: e))
                        .toList(),
                  ),
                  _buildFilterSubtitle(
                    context,
                    AppLocalizations.of(context)!.degusSearchPlaces,
                    Icons.place_outlined,
                  ),
                  Wrap(
                    children: state.availablePlaces
                        .map((e) => _DegustationPlaceSearchTag(place: e))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Padding _buildFilterSubtitle(
      BuildContext context, String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Icon(icon, size: 16),
        ],
      ),
    );
  }

  Widget _buildActiveSearchTagWrap(
    FilterDegustationState state,
    BuildContext context,
  ) {
    return Wrap(
      children: [
        ...state.alcoholTypeFilter.map(
          (e) => _DegustationAlcTypeSearchTag(type: e),
        ),
        ...state.originFilter.map(
          (e) => _DegustationOriginSearchTag(origin: e),
        ),
        ...state.placeFilter.map(
          (e) => _DegustationPlaceSearchTag(place: e),
        ),
      ],
    );
  }
}

class _TextSearchLine extends StatefulWidget {
  const _TextSearchLine({
    Key? key,
  }) : super(key: key);

  @override
  State<_TextSearchLine> createState() => __TextSearchLineState();
}

class __TextSearchLineState extends State<_TextSearchLine> {
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.addListener(_textSearchLineChange);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: _textController,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.degusSearchHint,
          suffixIcon: IconButton(
            icon: _textController.text.isEmpty
                ? const Icon(Icons.search)
                : const Icon(Icons.cancel),
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                _textController.clear();
              }
            },
          ),
        ),
      ),
    );
  }

  void _textSearchLineChange() {
    BlocProvider.of<FilterDegustationBloc>(context)
        .add(DegusTextFilter(_textController.text));
    setState(() {
      // Just to trigger rebuild of icons
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}

abstract class _DegustationSearchTag extends StatelessWidget {
  final FilterDegustationEvent onPressedEvent;

  const _DegustationSearchTag({
    Key? key,
    required this.onPressedEvent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterDegustationBloc, FilterDegustationState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).focusColor,
              border: Border.all(color: getAppBarColor(context)),
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 1.0,
                horizontal: 4,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_getLabelText(context)),
                  AddSwitch(
                    isOn: _isOn(state),
                    onPressed: () {
                      BlocProvider.of<FilterDegustationBloc>(context).add(
                        onPressedEvent,
                      );
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool _isOn(FilterDegustationState state);

  String _getLabelText(BuildContext context);
}

class _DegustationAlcTypeSearchTag extends _DegustationSearchTag {
  final DegusAlcoholType type;

  _DegustationAlcTypeSearchTag({
    Key? key,
    required this.type,
  }) : super(key: key, onPressedEvent: DegusAlcoholTypeFilter(type: type));

  @override
  String _getLabelText(BuildContext context) {
    return tDegusAlcoholType(type, context);
  }

  @override
  bool _isOn(FilterDegustationState state) {
    return !state.alcoholTypeFilter.contains(type);
  }
}

class _DegustationOriginSearchTag extends _DegustationSearchTag {
  final String origin;
  _DegustationOriginSearchTag({
    Key? key,
    required this.origin,
  }) : super(key: key, onPressedEvent: DegusOriginFilter(origin: origin));

  @override
  String _getLabelText(BuildContext context) {
    return origin;
  }

  @override
  bool _isOn(FilterDegustationState state) {
    return !state.originFilter.contains(origin);
  }
}

class _DegustationPlaceSearchTag extends _DegustationSearchTag {
  final String place;
  _DegustationPlaceSearchTag({
    Key? key,
    required this.place,
  }) : super(key: key, onPressedEvent: DegusPlaceFilter(place: place));

  @override
  String _getLabelText(BuildContext context) {
    return place;
  }

  @override
  bool _isOn(FilterDegustationState state) {
    return !state.placeFilter.contains(place);
  }
}
