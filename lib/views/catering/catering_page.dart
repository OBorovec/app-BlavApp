import 'package:blavapp/bloc/data_catering/catering_bloc.dart';
import 'package:blavapp/bloc/data_degustation/degustation_bloc.dart';
import 'package:blavapp/bloc/event_focus/event_focus_bloc.dart';
import 'package:blavapp/components/_pages/bottom_navigation.dart';
import 'package:blavapp/components/_pages/root_page.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:blavapp/views/catering/catering_list.dart';
import 'package:blavapp/views/catering/catering_place_list.dart';
import 'package:blavapp/views/catering/degustation_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CateringPage extends StatefulWidget {
  const CateringPage({Key? key}) : super(key: key);

  @override
  State<CateringPage> createState() => _CateringPageState();
}

class _CateringPageState extends State<CateringPage> {
  int navigationIndex = 0;
  final cateringPages = [
    const CateringList(),
    const DegustationList(),
    const CateringPlaceList(),
  ];

  @override
  Widget build(BuildContext context) {
    List<String> titles = [
      AppLocalizations.of(context)!.caterTitle,
      AppLocalizations.of(context)!.degusTitle,
      AppLocalizations.of(context)!.caterPlaceTitle,
    ];
    return RootPage(
      titleText: titles[navigationIndex],
      body: BlocBuilder<EventFocusBloc, EventFocusState>(
        builder: (context, state) {
          if (state is EventFocused) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => CateringBloc(
                    dataRepo: context.read<DataRepo>(),
                    eventTag: state.eventTag,
                  ),
                ),
                BlocProvider(
                  create: (context) => DegustationBloc(
                    dataRepo: context.read<DataRepo>(),
                    eventTag: state.eventTag,
                  ),
                ),
              ],
              child: cateringPages.elementAt(navigationIndex),
            );
          } else {
            return Center(
              child: Column(
                children: [
                  const CircularProgressIndicator(),
                  Text(AppLocalizations.of(context)!.stateErrorEventFocus),
                ],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        items: const [
          Icons.local_restaurant,
          Icons.local_bar,
          Icons.location_on,
        ],
        onTap: (index) {
          setState(() {
            navigationIndex = index;
          });
        },
      ),
    );
  }
}
