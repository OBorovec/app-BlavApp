import 'package:blavapp/bloc/catering/data_catering/catering_bloc.dart';
import 'package:blavapp/bloc/app_state/event_focus/event_focus_bloc.dart';
import 'package:blavapp/bloc/catering/filter_catering/filter_catering_bloc.dart';
import 'package:blavapp/bloc/catering/highlight_catering/highlight_catering_bloc.dart';
import 'package:blavapp/bloc/catering/places_catering/places_catering_bloc.dart';
import 'package:blavapp/components/_pages/bottom_navigation.dart';
import 'package:blavapp/components/_pages/root_page.dart';
import 'package:blavapp/components/control/button_switch.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:blavapp/utils/toasting.dart';
import 'package:blavapp/views/catering/catering_list.dart';
import 'package:blavapp/views/catering/catering_overview.dart';
import 'package:blavapp/views/catering/catering_place_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CateringPage extends StatefulWidget {
  const CateringPage({Key? key}) : super(key: key);

  @override
  State<CateringPage> createState() => _CateringPageState();
}

enum CateringPageContent { highlight, list, places }

class _CateringPageState extends State<CateringPage> {
  late String titleText;
  CateringPageContent content = CateringPageContent.highlight;

  final cateringContent = [
    const CateringOverview(),
    const CateringList(),
    const CateringPlaceList(),
  ];

  int contentIndex() {
    switch (content) {
      case CateringPageContent.highlight:
        return 0;
      case CateringPageContent.list:
        return 1;
      case CateringPageContent.places:
        return 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventFocusBloc, EventFocusState>(
      builder: (context, eventFocusState) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              lazy: false,
              create: (context) => CateringBloc(
                dataRepo: context.read<DataRepo>(),
                eventTag: eventFocusState.eventTag,
              ),
            ),
          ],
          child: BlocConsumer<CateringBloc, CateringState>(
            listenWhen: (previous, current) =>
                previous.message != current.message,
            listener: (context, state) {
              if (state.status == CateringStatus.failed) {
                Toasting.notifyToast(context, state.message);
              }
            },
            builder: (context, state) {
              if (state.status == CateringStatus.loaded) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => HighlightCateringBloc(
                        cateringBloc: context.read<CateringBloc>(),
                      ),
                    ),
                    BlocProvider(
                      create: (context) => FilterCateringBloc(
                        cateringBloc: context.read<CateringBloc>(),
                      ),
                    ),
                    BlocProvider(
                      create: (context) => PlacesCateringBloc(
                        cateringBloc: context.read<CateringBloc>(),
                      ),
                    ),
                  ],
                  child: Builder(builder: (context) {
                    return RootPage(
                      titleText: _pageTitle(),
                      body: _buildContent(),
                      actions: _buildActions(),
                      bottomNavigationBar: _buildBottomNavigation(context),
                    );
                  }),
                );
              } else if (state.status == CateringStatus.failed) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(Icons.error),
                      Text(AppLocalizations.of(context)!
                          .blocDataFail(state.message)),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const CircularProgressIndicator(),
                      Text(AppLocalizations.of(context)!.blocDataLoading),
                    ],
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }

  String _pageTitle() {
    switch (content) {
      case CateringPageContent.highlight:
        return AppLocalizations.of(context)!.caterTitle;
      case CateringPageContent.list:
        return AppLocalizations.of(context)!.caterListTitle;
      case CateringPageContent.places:
        return AppLocalizations.of(context)!.caterPlaceTitle;
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
      case CateringPageContent.list:
        return [
          BlocBuilder<FilterCateringBloc, FilterCateringState>(
            builder: (context, state) {
              return SearchSwitch(
                isOn: !state.searchActive,
                onPressed: () {
                  BlocProvider.of<FilterCateringBloc>(context)
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
      items: const [
        Icons.amp_stories,
        Icons.list,
        Icons.place,
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            setState(() {
              content = CateringPageContent.highlight;
            });
            break;
          case 1:
            setState(() {
              content = CateringPageContent.list;
            });
            break;
          case 2:
            setState(() {
              content = CateringPageContent.places;
            });
            break;
        }
      },
    );
  }
}
