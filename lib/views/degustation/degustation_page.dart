import 'package:blavapp/bloc/degustation/data_degustation/degustation_bloc.dart';
import 'package:blavapp/bloc/app_state/event_focus/event_focus_bloc.dart';
import 'package:blavapp/bloc/degustation/filter_degustation/filter_degustation_bloc.dart';
import 'package:blavapp/bloc/degustation/place_degustation/place_degustation_bloc.dart';
import 'package:blavapp/bloc/user_data/user_data/user_data_bloc.dart';
import 'package:blavapp/components/_pages/bottom_navigation.dart';
import 'package:blavapp/components/_pages/root_page.dart';
import 'package:blavapp/components/control/button_switch.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:blavapp/utils/toasting.dart';
import 'package:blavapp/views/degustation/degustation_list.dart';
import 'package:blavapp/views/degustation/degustation_overview.dart';
import 'package:blavapp/views/degustation/degustation_place_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DegustationPage extends StatefulWidget {
  const DegustationPage({Key? key}) : super(key: key);

  @override
  State<DegustationPage> createState() => _DegustationPageState();
}

enum DegustationPageContent { highlight, list, places }

class _DegustationPageState extends State<DegustationPage> {
  late String titleText;
  DegustationPageContent content = DegustationPageContent.highlight;

  final degustationContent = [
    const DegustationOverview(),
    const DegustationList(),
    const DegustationPlaceList(),
  ];

  int contentIndex() {
    switch (content) {
      case DegustationPageContent.highlight:
        return 0;
      case DegustationPageContent.list:
        return 1;
      case DegustationPageContent.places:
        return 2;
    }
  }

  // items: const [
  //         Icons.amp_stories,
  //         Icons.local_bar,
  //         Icons.location_on,
  //       ],

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventFocusBloc, EventFocusState>(
      builder: (context, eventFocusState) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              lazy: false,
              create: (context) => DegustationBloc(
                dataRepo: context.read<DataRepo>(),
                eventTag: eventFocusState.eventTag,
              ),
            ),
          ],
          child: BlocConsumer<DegustationBloc, DegustationState>(
            listenWhen: (previous, current) =>
                previous.message != current.message,
            listener: (context, state) {
              if (state.status == DegustationStatus.failed) {
                Toasting.notifyToast(context, state.message);
              }
            },
            builder: (context, state) {
              if (state.status == DegustationStatus.loaded) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => FilterDegustationBloc(
                        degustationBloc: context.read<DegustationBloc>(),
                        userDataBloc: context.read<UserDataBloc>(),
                      ),
                    ),
                    BlocProvider(
                      create: (context) => PlaceDegustationBloc(
                        degustationBloc: context.read<DegustationBloc>(),
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
              } else if (state.status == DegustationStatus.failed) {
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
      case DegustationPageContent.highlight:
        return AppLocalizations.of(context)!.degusHighlightTitle;
      case DegustationPageContent.list:
        return AppLocalizations.of(context)!.degusListTitle;
      case DegustationPageContent.places:
        return AppLocalizations.of(context)!.degusPlaceTitle;
    }
  }

  Widget _buildContent() {
    return IndexedStack(index: contentIndex(), children: degustationContent);
  }

  List<Widget> _buildActions() {
    switch (content) {
      case DegustationPageContent.list:
        return [
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
      items: const [
        Icons.amp_stories,
        Icons.local_bar,
        Icons.location_on,
      ],
      onTap: (index) {
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
            break;
          case 2:
            setState(() {
              content = DegustationPageContent.places;
            });
            break;
        }
      },
    );
  }
}
