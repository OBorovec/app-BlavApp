import 'package:blavapp/bloc/catering/data_catering/catering_bloc.dart';
import 'package:blavapp/bloc/catering/filter_beverages/filter_beverages_bloc.dart';
import 'package:blavapp/components/control/button_switch.dart';
import 'package:blavapp/model/catering.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BeverageSearch extends StatelessWidget {
  const BeverageSearch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBeveragesBloc, FilterBeveragesState>(
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
      FilterBeveragesState state, BuildContext context) {
    return Wrap(
      children: [
        ...state.placesFilter.map((e) => _buildPlaceSearchTag(e, context)),
        if (state.onlyHot)
          _SearchTag(
            onPressed: () => BlocProvider.of<FilterBeveragesBloc>(context)
                .add(const BeverageHotFilter(false)),
            isOn: (FilterBeveragesState state) => !state.onlyHot,
            text:
                AppLocalizations.of(context)!.contCateringBeverageListSearchHot,
          ),
        if (state.onlyAlcoholic)
          _SearchTag(
            onPressed: () => BlocProvider.of<FilterBeveragesBloc>(context)
                .add(const BeverageAlcoholicFilter(false)),
            isOn: (FilterBeveragesState state) => false,
            text: AppLocalizations.of(context)!.contCateringBeverageAlcohol,
          ),
        if (state.onlyNonAlcoholic)
          _SearchTag(
            onPressed: () => BlocProvider.of<FilterBeveragesBloc>(context)
                .add(const BeverageNonAlcoholicFilter(false)),
            isOn: (FilterBeveragesState state) => false,
            text: AppLocalizations.of(context)!.contCateringBeverageNonAlcohol,
          )
      ],
    );
  }

  Widget _buildPlaceSearchTag(String placeRef, BuildContext context) {
    CateringState prgState = BlocProvider.of<CateringBloc>(context).state;
    CaterPlace? place = prgState.cateringPlaces[placeRef];
    return _SearchTag(
      onPressed: () => BlocProvider.of<FilterBeveragesBloc>(context)
          .add(BeveragePlaceFilter(placeRef)),
      isOn: (FilterBeveragesState state) =>
          !state.placesFilter.contains(placeRef),
      text: place != null ? t(place.name, context) : '?$placeRef',
    );
  }

  Future<dynamic> _showSearchOptions(
    BuildContext context,
    FilterBeveragesState state,
  ) {
    return showModalBottomSheet(
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: BlocProvider.of<FilterBeveragesBloc>(context),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.contCateringSearchPredef,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 8),
                  _buildModalSubtitle(
                    context,
                    AppLocalizations.of(context)!.contCateringListSearchPlaces,
                    Icons.place_outlined,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: state.availablePlaces
                        .map((e) => _buildPlaceSearchTag(e, context))
                        .toList(),
                  ),
                  const SizedBox(height: 8),
                  _SearchCheckbox(
                    icon: const Icon(
                      Icons.coffee,
                      size: 16,
                    ),
                    text: AppLocalizations.of(context)!.contCateringBeverageHot,
                    checkboxValue: (FilterBeveragesState state) =>
                        state.onlyHot,
                    onChanged: (value) =>
                        BlocProvider.of<FilterBeveragesBloc>(context)
                            .add(BeverageHotFilter(value ?? false)),
                  ),
                  const SizedBox(height: 8),
                  _SearchCheckbox(
                      icon: const Icon(
                        Icons.local_bar,
                        size: 16,
                      ),
                      text: AppLocalizations.of(context)!
                          .contCateringBeverageAlcohol,
                      checkboxValue: (FilterBeveragesState state) =>
                          state.onlyAlcoholic,
                      onChanged: (value) =>
                          BlocProvider.of<FilterBeveragesBloc>(context)
                              .add(BeverageAlcoholicFilter(value ?? false))),
                  const SizedBox(height: 8),
                  _SearchCheckbox(
                      icon: const Icon(
                        Icons.local_bar_outlined,
                        size: 16,
                      ),
                      text: AppLocalizations.of(context)!
                          .contCateringBeverageNonAlcohol,
                      checkboxValue: (FilterBeveragesState state) =>
                          state.onlyNonAlcoholic,
                      onChanged: (value) {
                        BlocProvider.of<FilterBeveragesBloc>(context)
                            .add(BeverageNonAlcoholicFilter(
                          value ?? false,
                        ));
                      }),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildModalSubtitle(
    BuildContext context,
    String text,
    IconData icon,
  ) {
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
    BlocProvider.of<FilterBeveragesBloc>(context)
        .add(BeverageTextFilter(_textController.text));
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

class _SearchTag extends StatelessWidget {
  final void Function() onPressed;
  final bool Function(FilterBeveragesState state) isOn;
  final String text;

  const _SearchTag(
      {Key? key,
      required this.onPressed,
      required this.isOn,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBeveragesBloc, FilterBeveragesState>(
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
                vertical: 2.0,
                horizontal: 8,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(text),
                  AddSwitch(
                    isOn: isOn(state),
                    onPressed: onPressed,
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
}

class _SearchCheckbox extends StatelessWidget {
  final Widget icon;
  final String text;
  final bool Function(FilterBeveragesState state) checkboxValue;
  final void Function(bool?) onChanged;
  const _SearchCheckbox({
    Key? key,
    required this.icon,
    required this.text,
    required this.checkboxValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 8),
          Text(
            text,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Expanded(child: Container()),
          BlocBuilder<FilterBeveragesBloc, FilterBeveragesState>(
            builder: (context, state) {
              return Checkbox(
                value: checkboxValue(state),
                onChanged: onChanged,
              );
            },
          )
        ],
      ),
    );
  }
}
