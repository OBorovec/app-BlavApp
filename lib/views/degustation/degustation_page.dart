import 'package:blavapp/bloc/degustation/data_degustation/degustation_bloc.dart';
import 'package:blavapp/bloc/degustation/filter_degustation/filter_degustation_bloc.dart';
import 'package:blavapp/bloc/degustation/highlight_degustation/highlight_degustation_bloc.dart';
import 'package:blavapp/bloc/user_data/local_user_data/local_user_data_bloc.dart';
import 'package:blavapp/bloc/user_data/user_data/user_data_bloc.dart';
import 'package:blavapp/components/pages/aspects/bottom_navigation.dart';
import 'package:blavapp/components/pages/page_root.dart';
import 'package:blavapp/components/page_content/data_error_page.dart';
import 'package:blavapp/components/page_content/data_loading_page.dart';
import 'package:blavapp/components/control/button_switch.dart';
import 'package:blavapp/views/degustation/degustation_list.dart';
import 'package:blavapp/views/degustation/degustation_highlight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';

class DegustationPage extends StatefulWidget {
  const DegustationPage({Key? key}) : super(key: key);

  @override
  State<DegustationPage> createState() => _DegustationPageState();
}

enum DegustationPageContent {
  highlight,
  list,
  favoriteList,
}

class _DegustationPageState extends State<DegustationPage> {
  late String titleText;
  DegustationPageContent content = DegustationPageContent.highlight;
  int tabIndex = 0;

  final degustationContent = [
    const DegustationHighlight(),
    const DegustationList(),
  ];

  int contentIndex() {
    switch (content) {
      case DegustationPageContent.highlight:
        return 0;
      case DegustationPageContent.list:
        return 1;
      case DegustationPageContent.favoriteList:
        return 1;
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
          content = DegustationPageContent.highlight;
        });
        break;
      case 1:
        setState(() {
          content = DegustationPageContent.list;
        });
        context
            .read<FilterDegustationBloc>()
            .add(const UseMyFavoriteFilter(false));
        break;
      case 2:
        setState(() {
          content = DegustationPageContent.favoriteList;
        });
        context
            .read<FilterDegustationBloc>()
            .add(const UseMyFavoriteFilter(true));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DegustationBloc, DegustationState>(
      builder: (context, state) {
        switch (state.status) {
          case DegustationStatus.loaded:
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => HighlightDegustationBloc(
                    degustationBloc: context.read<DegustationBloc>(),
                    userDataBloc: context.read<UserDataBloc>(),
                    localUserDataBloc: context.read<LocalUserDataBloc>(),
                  ),
                ),
                BlocProvider(
                  create: (context) => FilterDegustationBloc(
                    degustationBloc: context.read<DegustationBloc>(),
                    userDataBloc: context.read<UserDataBloc>(),
                    localUserDataBloc: context.read<LocalUserDataBloc>(),
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
          case DegustationStatus.error:
            return DataErrorPage(message: state.message);
          case DegustationStatus.initial:
            return const DataLoadingPage();
        }
      },
    );
  }

  String _pageTitle() {
    switch (content) {
      case DegustationPageContent.highlight:
        return AppLocalizations.of(context)!.contDegustationHighlightTitle;
      case DegustationPageContent.list:
        return AppLocalizations.of(context)!.contDegustationListTitle;
      case DegustationPageContent.favoriteList:
        return AppLocalizations.of(context)!.contDegustationListFavoriteTitle;
    }
  }

  Widget _buildContent() {
    return IndexedStack(index: contentIndex(), children: degustationContent);
  }

  List<Widget> _buildActions() {
    switch (content) {
      case DegustationPageContent.list:
      case DegustationPageContent.favoriteList:
        return [
          BlocBuilder<FilterDegustationBloc, FilterDegustationState>(
            builder: (context, state) {
              return ExploreSwitch(
                isOn: state.exploreMode,
                onPressed: () {
                  BlocProvider.of<FilterDegustationBloc>(context)
                      .add(const ToggleExplore());
                },
              );
            },
          ),
          BlocBuilder<FilterDegustationBloc, FilterDegustationState>(
            builder: (context, state) {
              return SearchSwitch(
                isOn: !state.searchActive,
                onPressed: () {
                  BlocProvider.of<FilterDegustationBloc>(context)
                      .add(const ToggleSearch());
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
        Icons.local_bar,
        Icons.favorite,
      ],
      onTap: (index) => _indexChange(index, context),
    );
  }
}
