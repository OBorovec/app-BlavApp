import 'package:blavapp/bloc/catering/data_catering/catering_bloc.dart';
import 'package:blavapp/bloc/catering/filter_meals/filter_meals_bloc.dart';
import 'package:blavapp/components/control/button_switch.dart';
import 'package:blavapp/constants/icons.dart';
import 'package:blavapp/model/catering.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MealSearch extends StatelessWidget {
  const MealSearch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterMealsBloc, FilterMealsState>(
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
      FilterMealsState state, BuildContext context) {
    return Wrap(
      children: [
        ...state.itemTypeFilter.map((e) => _buildTypeSearchTag(e, context)),
        ...state.placesFilter.map((e) => _buildPlaceSearchTag(e, context)),
        ...state.allergensFilter
            .map((e) => _buildAllergenSearchTag(e, context)),
        if (state.onlyVegetarian)
          _SearchTag(
            onPressed: () => BlocProvider.of<FilterMealsBloc>(context)
                .add(const MealVegetarianFilter(false)),
            isOn: (FilterMealsState state) => !state.onlyVegetarian,
            text: AppLocalizations.of(context)!
                .contCateringMealListSearchVegetarian,
          ),
        if (state.onlyVegan)
          _SearchTag(
            onPressed: () => BlocProvider.of<FilterMealsBloc>(context)
                .add(const MealVeganFilter(false)),
            isOn: (FilterMealsState state) => !state.onlyVegan,
            text: AppLocalizations.of(context)!
                .contCateringMealListSearchVegetarian,
          ),
        if (state.onlyGlutenFree)
          _SearchTag(
            onPressed: () => BlocProvider.of<FilterMealsBloc>(context)
                .add(const MealGlutenFreeFilter(false)),
            isOn: (FilterMealsState state) => !state.onlyGlutenFree,
            text: AppLocalizations.of(context)!
                .contCateringMealListSearchGlutenFree,
          ),
      ],
    );
  }

  Widget _buildTypeSearchTag(MealItemType type, BuildContext context) {
    return _SearchTag(
      onPressed: () =>
          BlocProvider.of<FilterMealsBloc>(context).add(MealTypeFilter(type)),
      isOn: (FilterMealsState state) => !state.itemTypeFilter.contains(type),
      text: tMealItemType(type, context),
    );
  }

  Widget _buildPlaceSearchTag(String placeRef, BuildContext context) {
    CateringState prgState = BlocProvider.of<CateringBloc>(context).state;
    CaterPlace? place = prgState.cateringPlaces[placeRef];
    return _SearchTag(
      onPressed: () => BlocProvider.of<FilterMealsBloc>(context)
          .add(MealPlaceFilter(placeRef)),
      isOn: (FilterMealsState state) => !state.placesFilter.contains(placeRef),
      text: place != null ? t(place.name, context) : '?$placeRef',
    );
  }

  Widget _buildAllergenSearchTag(int allergenNum, BuildContext context) {
    return _SearchTag(
      onPressed: () => BlocProvider.of<FilterMealsBloc>(context)
          .add(MealAllergenFilter(allergenNum)),
      isOn: (FilterMealsState state) =>
          !state.allergensFilter.contains(allergenNum),
      text: '#$allergenNum',
    );
  }

  Future<dynamic> _showSearchOptions(
    BuildContext context,
    FilterMealsState state,
  ) {
    return showModalBottomSheet(
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: BlocProvider.of<FilterMealsBloc>(context),
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
                    AppLocalizations.of(context)!.contCateringListSearchTypes,
                    Icons.category_outlined,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: state.availableItemTypes
                        .map((e) => _buildTypeSearchTag(e, context))
                        .toList(),
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
                  _buildModalSubtitle(
                    context,
                    AppLocalizations.of(context)!
                        .contCateringMealListSearchAllergens,
                    Icons.warning_outlined,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: state.availableAllergens
                        .map((e) => _buildAllergenSearchTag(e, context))
                        .toList(),
                  ),
                  const SizedBox(height: 8),
                  _CateringSearchCheckbox(
                      icon: ImageIcon(
                        AppIcons.vegetarian,
                        size: 16,
                      ),
                      text: AppLocalizations.of(context)!
                          .contCateringMealListSearchVegetarian,
                      checkboxValue: (FilterMealsState state) =>
                          state.onlyVegetarian,
                      onChanged: (value) =>
                          BlocProvider.of<FilterMealsBloc>(context)
                              .add(MealVegetarianFilter(value ?? false))),
                  const SizedBox(height: 8),
                  _CateringSearchCheckbox(
                      icon: ImageIcon(
                        AppIcons.vegan,
                        size: 16,
                      ),
                      text: AppLocalizations.of(context)!
                          .contCateringMealListSearchVegan,
                      checkboxValue: (FilterMealsState state) =>
                          state.onlyVegan,
                      onChanged: (value) =>
                          BlocProvider.of<FilterMealsBloc>(context)
                              .add(MealVeganFilter(value ?? false))),
                  const SizedBox(height: 8),
                  _CateringSearchCheckbox(
                      icon: ImageIcon(
                        AppIcons.glutenFree,
                        size: 16,
                      ),
                      text: AppLocalizations.of(context)!
                          .contCateringMealListSearchGlutenFree,
                      checkboxValue: (FilterMealsState state) =>
                          state.onlyGlutenFree,
                      onChanged: (value) =>
                          BlocProvider.of<FilterMealsBloc>(context)
                              .add(MealGlutenFreeFilter(value ?? false))),
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
    BlocProvider.of<FilterMealsBloc>(context)
        .add(MealTextFilter(_textController.text));
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
  final bool Function(FilterMealsState state) isOn;
  final String text;

  const _SearchTag(
      {Key? key,
      required this.onPressed,
      required this.isOn,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterMealsBloc, FilterMealsState>(
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

class _CateringSearchCheckbox extends StatelessWidget {
  final Widget icon;
  final String text;
  final bool Function(FilterMealsState state) checkboxValue;
  final void Function(bool?) onChanged;
  const _CateringSearchCheckbox({
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
          BlocBuilder<FilterMealsBloc, FilterMealsState>(
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
