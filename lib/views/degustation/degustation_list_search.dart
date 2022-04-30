import 'package:blavapp/bloc/degustation/data_degustation/degustation_bloc.dart';
import 'package:blavapp/bloc/degustation/filter_degustation/filter_degustation_bloc.dart';
import 'package:blavapp/components/control/button_switch.dart';
import 'package:blavapp/model/degustation.dart';
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
          (e) => _DegustationPlaceSearchTag(placeRef: e),
        ),
      ],
    );
  }
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
                  AppLocalizations.of(context)!.contDegustationListSearchPredef,
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(height: 8),
                _buildModalSubtitle(
                  context,
                  AppLocalizations.of(context)!.contDegustationListSearchTypes,
                  Icons.access_time_outlined,
                ),
                Wrap(
                  children: state.availableAlcoholTypes
                      .map((e) => _DegustationAlcTypeSearchTag(type: e))
                      .toList(),
                ),
                _buildModalSubtitle(
                  context,
                  AppLocalizations.of(context)!.contDegustationListSearchOrigin,
                  Icons.place_outlined,
                ),
                Wrap(
                  children: state.availableOrigins
                      .map((e) => _DegustationOriginSearchTag(origin: e))
                      .toList(),
                ),
                _buildModalSubtitle(
                  context,
                  AppLocalizations.of(context)!.contDegustationListSearchPlaces,
                  Icons.place_outlined,
                ),
                Wrap(
                  children: state.availablePlaces
                      .map((e) => _DegustationPlaceSearchTag(placeRef: e))
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

Padding _buildModalSubtitle(BuildContext context, String text, IconData icon) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Row(
      children: [
        Icon(icon, size: 16),
        const SizedBox(width: 8),
        Text(
          text,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ],
    ),
  );
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
          hintText: AppLocalizations.of(context)!.contDegustationListSearchHint,
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
  final String placeRef;
  _DegustationPlaceSearchTag({
    Key? key,
    required this.placeRef,
  }) : super(key: key, onPressedEvent: DegusPlaceFilter(place: placeRef));

  @override
  String _getLabelText(BuildContext context) {
    DegustationState prgState = BlocProvider.of<DegustationBloc>(context).state;
    DegusPlace? place = prgState.degustationPlaces[placeRef];
    return place != null ? t(place.name, context) : '?$placeRef';
  }

  @override
  bool _isOn(FilterDegustationState state) {
    return !state.placeFilter.contains(placeRef);
  }
}
