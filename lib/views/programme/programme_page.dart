import 'package:blavapp/bloc/programme/data_programme/programme_bloc.dart';
import 'package:blavapp/bloc/app/event_focus/event_focus_bloc.dart';
import 'package:blavapp/bloc/programme/filter_programme/filter_programme_bloc.dart';
import 'package:blavapp/bloc/programme/highlight_programme/highlight_programme_bloc.dart';
import 'package:blavapp/bloc/programme/user_programme_agenda/user_programme_agenda_bloc.dart';
import 'package:blavapp/bloc/user_data/user_data/user_data_bloc.dart';
import 'package:blavapp/components/page_hierarchy/bottom_navigation.dart';
import 'package:blavapp/components/page_hierarchy/root_page.dart';
import 'package:blavapp/components/bloc_pages/bloc_error_page.dart';
import 'package:blavapp/components/bloc_pages/bloc_loading_page.dart';
import 'package:blavapp/components/control/button_switch.dart';
import 'package:blavapp/utils/toasting.dart';
import 'package:blavapp/views/programme/programme_highlight.dart';
import 'package:blavapp/views/programme/programme_agenda.dart';
import 'package:blavapp/views/programme/programme_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProgrammePage extends StatefulWidget {
  const ProgrammePage({Key? key}) : super(key: key);

  @override
  State<ProgrammePage> createState() => _ProgrammePageState();
}

enum ProgrammePageContent { highlight, list, mylist, agenda }

class _ProgrammePageState extends State<ProgrammePage> {
  late String titleText;
  ProgrammePageContent content = ProgrammePageContent.highlight;

  final programmeContent = [
    const ProgrammeHighlight(),
    const ProgrammeList(),
    const ProgrammeAgenda(),
  ];

  int contentIndex() {
    switch (content) {
      case ProgrammePageContent.highlight:
        return 0;
      case ProgrammePageContent.list:
        return 1;
      case ProgrammePageContent.mylist:
        return 1;
      case ProgrammePageContent.agenda:
        return 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProgrammeBloc, ProgrammeState>(
      listenWhen: (previous, current) => previous.message != current.message,
      listener: (context, state) {
        if (state.status == ProgrammeStatus.error) {
          Toasting.notifyToast(context, state.message);
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case ProgrammeStatus.loaded:
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => HighlightProgrammeBloc(
                    programmeBloc: context.read<ProgrammeBloc>(),
                    userDataBloc: context.read<UserDataBloc>(),
                  ),
                ),
                BlocProvider(
                  create: (context) => FilterProgrammeBloc(
                    programmeBloc: context.read<ProgrammeBloc>(),
                    userDataBloc: context.read<UserDataBloc>(),
                  ),
                ),
                BlocProvider(
                  create: (context) => UserProgrammeAgendaBloc(
                    programmeBloc: context.read<ProgrammeBloc>(),
                    userDataBloc: context.read<UserDataBloc>(),
                    event: context.read<EventFocusBloc>().state.event!,
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
          case ProgrammeStatus.error:
            return BlocErrorPage(message: state.message);
          case ProgrammeStatus.initial:
            return const BlocLoadingPage();
        }
      },
    );
  }

  String _pageTitle() {
    switch (content) {
      case ProgrammePageContent.highlight:
        return AppLocalizations.of(context)!.progHighlight;
      case ProgrammePageContent.list:
        return AppLocalizations.of(context)!.progTitle;
      case ProgrammePageContent.mylist:
        return AppLocalizations.of(context)!.progMyTitle;
      case ProgrammePageContent.agenda:
        return AppLocalizations.of(context)!.progAgendTitle;
    }
  }

  Widget _buildContent() {
    return IndexedStack(
      index: contentIndex(),
      children: programmeContent,
    );
  }

  List<Widget> _buildActions() {
    switch (content) {
      case ProgrammePageContent.list:
        return [
          BlocBuilder<FilterProgrammeBloc, FilterProgrammeState>(
            builder: (context, state) {
              return SearchSwitch(
                isOn: !state.searchActive,
                onPressed: () {
                  BlocProvider.of<FilterProgrammeBloc>(context)
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
        Icons.event_available,
        Icons.view_agenda,
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            setState(() {
              content = ProgrammePageContent.highlight;
            });
            break;
          case 1:
            setState(() {
              content = ProgrammePageContent.list;
            });
            context
                .read<FilterProgrammeBloc>()
                .add(const UseMyProgrammeFilter(false));
            break;
          case 2:
            setState(() {
              content = ProgrammePageContent.mylist;
            });
            context
                .read<FilterProgrammeBloc>()
                .add(const UseMyProgrammeFilter(true));
            break;
          case 3:
            setState(() {
              content = ProgrammePageContent.agenda;
            });
            break;
        }
      },
    );
  }
}
