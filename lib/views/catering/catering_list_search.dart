import 'package:blavapp/bloc/catering/data_catering/catering_bloc.dart';
import 'package:blavapp/bloc/catering/filter_catering/filter_catering_bloc.dart';
import 'package:blavapp/components/control/button_switch.dart';
import 'package:blavapp/model/catering.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CateringSearchTile extends StatelessWidget {
  const CateringSearchTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCateringBloc, FilterCateringState>(
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
    FilterCateringState state,
  ) {
    return showModalBottomSheet(
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: BlocProvider.of<FilterCateringBloc>(context),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.contCateringListSearchPredef,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 8),
                  _buildFilterSubtitle(
                    context,
                    AppLocalizations.of(context)!.contCateringListSearchTypes,
                    Icons.access_time_outlined,
                  ),
                  Wrap(
                    children: state.availableItemTypes
                        .map((e) => _CateringTypeSearchTag(itemType: e))
                        .toList(),
                  ),
                  _buildFilterSubtitle(
                    context,
                    AppLocalizations.of(context)!.contCateringListSearchPlaces,
                    Icons.place_outlined,
                  ),
                  Wrap(
                    children: state.availablePlaces
                        .map((e) => _CateringPlaceSearchTag(placeRef: e))
                        .toList(),
                  ),
                  _buildFilterSubtitle(
                    context,
                    AppLocalizations.of(context)!
                        .contCateringListSearchAllergens,
                    Icons.place_outlined,
                  ),
                  Wrap(
                    children: state.availableAllergens
                        .map((e) => _CateringAllergenSearchTag(allergenNum: e))
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
    FilterCateringState state,
    BuildContext context,
  ) {
    return Wrap(
      children: [
        ...state.itemTypeFilter.map((e) => _CateringTypeSearchTag(itemType: e)),
        ...state.placesFilter.map((e) => _CateringPlaceSearchTag(placeRef: e)),
        ...state.allergensFilter
            .map((e) => _CateringAllergenSearchTag(allergenNum: e)),
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
          hintText: AppLocalizations.of(context)!.contCateringListSearchHint,
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
    BlocProvider.of<FilterCateringBloc>(context)
        .add(CateringTextFilter(_textController.text));
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

abstract class _CateringSearchTag extends StatelessWidget {
  final FilterCateringEvent onPressedEvent;

  const _CateringSearchTag({
    Key? key,
    required this.onPressedEvent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCateringBloc, FilterCateringState>(
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
                      BlocProvider.of<FilterCateringBloc>(context).add(
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

  bool _isOn(FilterCateringState state);

  String _getLabelText(BuildContext context);
}

class _CateringTypeSearchTag extends _CateringSearchTag {
  final CaterItemType itemType;

  _CateringTypeSearchTag({
    Key? key,
    required this.itemType,
  }) : super(key: key, onPressedEvent: CateringTypeFilter(itemType));

  @override
  String _getLabelText(BuildContext context) {
    return tCaterItemType(itemType, context);
  }

  @override
  bool _isOn(FilterCateringState state) {
    return !state.itemTypeFilter.contains(itemType);
  }
}

class _CateringPlaceSearchTag extends _CateringSearchTag {
  final String placeRef;
  _CateringPlaceSearchTag({
    Key? key,
    required this.placeRef,
  }) : super(key: key, onPressedEvent: CateringPlaceFilter(placeRef));

  @override
  String _getLabelText(BuildContext context) {
    CateringState prgState = BlocProvider.of<CateringBloc>(context).state;
    CaterPlace? place = prgState.cateringPlaces[placeRef];
    return place != null ? t(place.name, context) : '?$placeRef';
  }

  @override
  bool _isOn(FilterCateringState state) {
    return !state.placesFilter.contains(placeRef);
  }
}

class _CateringAllergenSearchTag extends _CateringSearchTag {
  final int allergenNum;
  _CateringAllergenSearchTag({
    Key? key,
    required this.allergenNum,
  }) : super(key: key, onPressedEvent: CateringAllergenFilter(allergenNum));

  @override
  String _getLabelText(BuildContext context) {
    return '#$allergenNum';
  }

  @override
  bool _isOn(FilterCateringState state) {
    return !state.allergensFilter.contains(allergenNum);
  }
}
