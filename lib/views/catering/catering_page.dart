import 'package:blavapp/bloc/catering/data_catering/catering_bloc.dart';
import 'package:blavapp/bloc/catering/filter_beverages/filter_beverages_bloc.dart';
import 'package:blavapp/bloc/catering/filter_meals/filter_meals_bloc.dart';
import 'package:blavapp/bloc/catering/highlight_catering/highlight_catering_bloc.dart';
import 'package:blavapp/bloc/user_data/user_data/user_data_bloc.dart';
import 'package:blavapp/components/pages/aspects/bottom_navigation.dart';
import 'package:blavapp/components/page_content/data_error_page.dart';
import 'package:blavapp/components/page_content/data_loading_page.dart';
import 'package:blavapp/components/pages/page_root.dart';
import 'package:blavapp/components/control/button_switch.dart';
import 'package:blavapp/views/catering/beverage_list.dart';
import 'package:blavapp/views/catering/meal_list.dart';
import 'package:blavapp/views/catering/catering_highlight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';

class CateringPage extends StatefulWidget {
  const CateringPage({Key? key}) : super(key: key);

  @override
  State<CateringPage> createState() => _CateringPageState();
}

enum CateringPageContent {
  highlight,
  meals,
  beverages,
}

class _CateringPageState extends State<CateringPage> {
  late String titleText;
  CateringPageContent content = CateringPageContent.highlight;
  int tabIndex = 0;

  final cateringContent = [
    const CateringOverview(),
    const MealList(),
    const BeverageList(),
  ];

  int contentIndex() {
    switch (content) {
      case CateringPageContent.highlight:
        return 0;
      case CateringPageContent.meals:
        return 1;
      case CateringPageContent.beverages:
        return 2;
    }
  }

  void _indexChange(int index, BuildContext context) {
    if (index < 0 || index > 2) {
      return;
    }
    tabIndex = index;
    switch (index) {
      case 0:
        setState(() {
          content = CateringPageContent.highlight;
        });
        break;
      case 1:
        setState(() {
          content = CateringPageContent.meals;
        });
        break;
      case 2:
        setState(() {
          content = CateringPageContent.beverages;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CateringBloc, CateringState>(
      builder: (context, state) {
        switch (state.status) {
          case CateringStatus.loaded:
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => HighlightCateringBloc(
                    cateringBloc: context.read<CateringBloc>(),
                    userDataBloc: context.read<UserDataBloc>(),
                  ),
                ),
                BlocProvider(
                  create: (context) => FilterMealsBloc(
                    cateringBloc: context.read<CateringBloc>(),
                  ),
                ),
                BlocProvider(
                  create: (context) => FilterBeveragesBloc(
                    cateringBloc: context.read<CateringBloc>(),
                  ),
                ),
              ],
              child: Builder(builder: (context) {
                return SwipeDetector(
                  onSwipeLeft: (offset) => _indexChange(tabIndex += 1, context),
                  onSwipeRight: (offset) =>
                      _indexChange(tabIndex -= 1, context),
                  child: RootPage(
                    titleText: _pageTitle(),
                    body: _buildContent(),
                    actions: _buildActions(),
                    bottomNavigationBar: _buildBottomNavigation(context),
                  ),
                );
              }),
            );
          case CateringStatus.error:
            return DataErrorPage(message: state.message);
          case CateringStatus.initial:
            return const DataLoadingPage();
        }
      },
    );
  }

  String _pageTitle() {
    switch (content) {
      case CateringPageContent.highlight:
        return AppLocalizations.of(context)!.contCateringHighlightTitle;
      case CateringPageContent.meals:
        return AppLocalizations.of(context)!.contCateringMealListTitle;
      case CateringPageContent.beverages:
        return AppLocalizations.of(context)!.contCateringBeverageListTitle;
    }
  }

  Widget _buildContent() {
    return IndexedStack(
      index: contentIndex(),
      children: cateringContent,
    );
  }

  List<Widget> _buildActions() {
    switch (content) {
      case CateringPageContent.meals:
        return [
          BlocBuilder<FilterMealsBloc, FilterMealsState>(
            builder: (context, state) {
              return SearchSwitch(
                isOn: !state.searchActive,
                onPressed: () {
                  BlocProvider.of<FilterMealsBloc>(context)
                      .add(const ToggleMealSearch());
                },
              );
            },
          ),
        ];
      case CateringPageContent.beverages:
        return [
          BlocBuilder<FilterBeveragesBloc, FilterBeveragesState>(
            builder: (context, state) {
              return SearchSwitch(
                isOn: !state.searchActive,
                onPressed: () {
                  BlocProvider.of<FilterBeveragesBloc>(context)
                      .add(const ToggleBeverageSearch());
                },
              );
            },
          ),
        ];
      default:
        return [];
    }
  }

  AppBottomNavigationBar _buildBottomNavigation(BuildContext context) {
    return AppBottomNavigationBar(
      index: tabIndex,
      items: const [
        Icons.info,
        Icons.restaurant_menu,
        Icons.coffee,
      ],
      onTap: (index) => _indexChange(index, context),
    );
  }
}
