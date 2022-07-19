import 'package:blavapp/bloc/data_programme/programme_bloc.dart';
import 'package:blavapp/bloc/event_focus/event_focus_bloc.dart';
import 'package:blavapp/bloc/filter_programme/filter_programme_bloc.dart';
import 'package:blavapp/bloc/user_data/user_data_bloc.dart';
import 'package:blavapp/components/_pages/bottom_navigation.dart';
import 'package:blavapp/components/_pages/root_page.dart';
import 'package:blavapp/components/control/button_switch.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:blavapp/utils/toasting.dart';
import 'package:blavapp/views/programme/myprogramme_agenda.dart';
import 'package:blavapp/views/programme/programme_list.dart';
import 'package:blavapp/views/programme/programme_search_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProgrammePage extends StatefulWidget {
  const ProgrammePage({Key? key}) : super(key: key);

  @override
  State<ProgrammePage> createState() => _ProgrammePageState();
}

enum ProgrammePageContent { list, agenda }

class _ProgrammePageState extends State<ProgrammePage> {
  ProgrammePageContent content = ProgrammePageContent.list;
  bool listMyProgramme = false;
  String titleText = '';
  bool activeSearch = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventFocusBloc, EventFocusState>(
      builder: (context, eventFocusState) {
        if (eventFocusState is EventFocused) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                lazy: false,
                create: (context) => ProgrammeBloc(
                  dataRepo: context.read<DataRepo>(),
                  eventTag: eventFocusState.eventTag,
                ),
              ),
            ],
            child: BlocConsumer<ProgrammeBloc, ProgrammeState>(
              listenWhen: (previous, current) =>
                  previous.message != current.message,
              listener: (context, state) {
                if (state.status == ProgrammeStatus.failed) {
                  Toasting.notifyToast(context, state.message);
                }
              },
              builder: (context, state) {
                if (state.status == ProgrammeStatus.loaded) {
                  return BlocProvider(
                    lazy: false,
                    create: (context) => FilterProgrammeBloc(
                      programmeBloc: context.read<ProgrammeBloc>(),
                      userDataBloc: context.read<UserDataBloc>(),
                    ),
                    child: Builder(builder: (context) {
                      return RootPage(
                        titleText: _pageTitle(),
                        body: _buildContent(eventFocusState),
                        actions: _buildActions(context),
                        bottomNavigationBar: _buildBottomNavigation(context),
                      );
                    }),
                  );
                } else if (state.status == ProgrammeStatus.failed) {
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
    );
  }

  String _pageTitle() {
    switch (content) {
      case ProgrammePageContent.list:
        if (listMyProgramme) {
          return AppLocalizations.of(context)!.progMyTitle;
        } else {
          return AppLocalizations.of(context)!.progTitle;
        }
      case ProgrammePageContent.agenda:
        return AppLocalizations.of(context)!.progAgendTitle;
      default:
        return '';
    }
  }

  Widget _buildContent(EventFocused eventFocusState) {
    switch (content) {
      case ProgrammePageContent.list:
        return Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Column(
            children: [
              if (activeSearch) const ProgrammeSearchTile(),
              const Expanded(
                child: ProgrammeList(),
              ),
            ],
          ),
        );
      case ProgrammePageContent.agenda:
        return MyProgrammeAgenda(
          minDate: eventFocusState.event.timestampStart,
          maxDate: eventFocusState.event.timestampEnd,
        );
      default:
        return Container();
    }
  }

  List<Widget> _buildActions(BuildContext context) {
    switch (content) {
      case ProgrammePageContent.list:
        return [
          SearchSwitch(
            isOn: !activeSearch,
            onPressed: () {
              setState(() {
                BlocProvider.of<FilterProgrammeBloc>(context)
                    .add(const ResetProgrammeFilters());
                activeSearch = !activeSearch;
              });
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
        Icons.event,
        Icons.event_available,
        Icons.view_agenda,
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            {
              setState(() {
                content = ProgrammePageContent.list;
                listMyProgramme = false;
                titleText = AppLocalizations.of(context)!.progTitle;
              });
            }
            context
                .read<FilterProgrammeBloc>()
                .add(const UseMyProgrammeFilter(false));
            break;
          case 1:
            {
              setState(() {
                content = ProgrammePageContent.list;
                listMyProgramme = true;
                titleText = AppLocalizations.of(context)!.progMyTitle;
              });
              context
                  .read<FilterProgrammeBloc>()
                  .add(const UseMyProgrammeFilter(true));
            }
            break;
          case 2:
            setState(() {
              content = ProgrammePageContent.agenda;
              titleText = AppLocalizations.of(context)!.progAgendTitle;
            });
            context
                .read<FilterProgrammeBloc>()
                .add(const UseMyProgrammeFilter(true));
            break;
          default:
            break;
        }
      },
    );
  }
}
