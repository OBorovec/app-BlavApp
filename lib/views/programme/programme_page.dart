import 'package:blavapp/bloc/programme/data_programme/programme_bloc.dart';
import 'package:blavapp/bloc/app/event/event_bloc.dart';
import 'package:blavapp/bloc/programme/filter_programme/filter_programme_bloc.dart';
import 'package:blavapp/bloc/programme/highlight_programme/highlight_programme_bloc.dart';
import 'package:blavapp/bloc/programme/user_programme_agenda/user_programme_agenda_bloc.dart';
import 'package:blavapp/bloc/user_data/user_data/user_data_bloc.dart';
import 'package:blavapp/components/pages/aspects/bottom_navigation.dart';
import 'package:blavapp/components/pages/page_root.dart';
import 'package:blavapp/components/page_content/data_error_page.dart';
import 'package:blavapp/components/page_content/data_loading_page.dart';
import 'package:blavapp/components/control/button_switch.dart';
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
    return BlocBuilder<ProgrammeBloc, ProgrammeState>(
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
                    event: context.read<EventBloc>().state.event!,
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
            return DataErrorPage(message: state.message);
          case ProgrammeStatus.initial:
            return const DataLoadingPage();
        }
      },
    );
  }

  String _pageTitle() {
    switch (content) {
      case ProgrammePageContent.highlight:
        return AppLocalizations.of(context)!.contProgrammeHighlight;
      case ProgrammePageContent.list:
        return AppLocalizations.of(context)!.contProgrammeListTitle;
      case ProgrammePageContent.mylist:
        return AppLocalizations.of(context)!.contProgrammeListMyTitle;
      case ProgrammePageContent.agenda:
        return AppLocalizations.of(context)!.contProgrammeAgendTitle;
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
      case ProgrammePageContent.mylist:
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
        Icons.info,
        Icons.list,
        Icons.bookmark,
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
