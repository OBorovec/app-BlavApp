import 'package:blavapp/bloc/app/event/event_bloc.dart';
import 'package:blavapp/bloc/user_data/local_user_data/local_user_data_bloc.dart';
import 'package:blavapp/components/images/app_network_image.dart';
import 'package:blavapp/components/page_content/data_loading_page.dart';
import 'package:blavapp/components/pages/page_root.dart';
import 'package:blavapp/components/views/collapsable_text_section.dart';
import 'package:blavapp/components/views/title_divider.dart';
import 'package:blavapp/model/common.dart';
import 'package:blavapp/model/event.dart';
import 'package:blavapp/utils/datetime_formatter.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventHomePage extends StatefulWidget {
  const EventHomePage({Key? key}) : super(key: key);

  @override
  State<EventHomePage> createState() => _EventHomePageState();
}

class _EventHomePageState extends State<EventHomePage> {
  List<bool> showFullExtrasText = [];
  final ScrollController _mainController = ScrollController();

  void _scrollDown() {
    _mainController.animateTo(
      _mainController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  void _scrollUp() {
    _mainController.animateTo(
      _mainController.position.minScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventBloc, EventState>(
      builder: (context, state) {
        switch (state.status) {
          case EventStatus.selected:
            if (showFullExtrasText.isEmpty) {
              showFullExtrasText = List<bool>.filled(
                state.event!.extras.length,
                false,
              );
            }
            return RootPage(
              titleText: t(state.event!.name, context),
              body: SingleChildScrollView(
                controller: _mainController,
                child: Column(children: [
                  if (state.event!.images.isNotEmpty)
                    _EventImage(event: state.event!),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        if (state.event!.sDesc != null)
                          _EventSubDescription(state: state),
                        if (state.event!.desc != null)
                          _EventDescription(state: state),
                        _EventTimes(state: state),
                        const SizedBox(height: 8),
                        ...state.event!.extras.map(
                          (Extras e) {
                            int index = state.event!.extras.indexOf(e);
                            return CollapsableTextSection(
                              title: t(e.title, context),
                              body: t(e.body, context),
                              isExpanded: showFullExtrasText[index],
                              onToggle: () => setState(() {
                                showFullExtrasText[index] =
                                    !showFullExtrasText[index];
                              }),
                            );
                          },
                        ).toList(),
                        _EventBoard(
                          state: state,
                          onEndReached: () => _scrollDown(),
                          onTopReached: () => _scrollUp(),
                        )
                      ],
                    ),
                  ),
                ]),
              ),
              actions: [
                if (showFullExtrasText.contains(true))
                  IconButton(
                    icon: const Icon(Icons.keyboard_arrow_up),
                    onPressed: () {
                      setState(() {
                        showFullExtrasText = List<bool>.filled(
                          state.event!.extras.length,
                          false,
                        );
                      });
                    },
                  ),
              ],
            );
          case EventStatus.init:
            return const DataLoadingPage();
          case EventStatus.empty:
            // TODO: add page localizations
            return RootPage(
              titleText: 'You still need to pick an event',
              body: Column(
                children: const [
                  Text('No event focused'),
                ],
              ),
            );
        }
      },
    );
  }
}

class _EventBoard extends StatefulWidget {
  final EventState state;
  final Function() onEndReached;
  final Function() onTopReached;
  const _EventBoard({
    Key? key,
    required this.state,
    required this.onEndReached,
    required this.onTopReached,
  }) : super(key: key);

  @override
  State<_EventBoard> createState() => _EventBoardState();
}

class _EventBoardState extends State<_EventBoard> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    _controller.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      widget.onEndReached();
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      widget.onTopReached();
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<LocalUserDataBloc, LocalUserDataState>(
      builder: (context, state) {
        List<BoardNote> notes = widget.state.event!.board
            .where(
              (BoardNote note) => !state.hiddenBoardNotes.contains(note.id),
            )
            .toList();
        print(notes);
        return Column(
          children: [
            const SizedBox(height: 16),
            TitleDivider(
                title: AppLocalizations.of(context)!.contEventHomeBoard),
            const SizedBox(height: 8),
            notes.isEmpty
                ? Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                .contEventHomeBoardEmpty,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          InkWell(
                            onTap: () =>
                                BlocProvider.of<LocalUserDataBloc>(context)
                                    .add(const ResetBoardNotes()),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .contEventHomeBoardReset,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox(
                    height: height * 0.6,
                    child: SingleChildScrollView(
                      controller: _controller,
                      padding: const EdgeInsets.only(bottom: 32.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: notes
                            .map(
                              (BoardNote note) => Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              t(note.title, context),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1,
                                              overflow: TextOverflow.clip,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () => BlocProvider.of<
                                                    LocalUserDataBloc>(context)
                                                .add(HideBoardNote(
                                                    noteId: note.id)),
                                            icon: const Icon(Icons.check),
                                          ),
                                          // IconButton(
                                          //   onPressed: () => null,
                                          //   icon: Icon(Icons.close),
                                          // ),
                                        ],
                                      ),
                                      Text(
                                        t(note.body, context),
                                        overflow: TextOverflow.clip,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
          ],
        );
      },
    );
  }
}

class _EventTimes extends StatelessWidget {
  final EventState state;
  const _EventTimes({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _EventDates(
              startDate: state.event!.dayStart,
              endDate: state.event!.dayEnd,
            ),
            _CountDownTimer(
              duration: state.remainingToStart,
              isOngoing: state.isOngoing,
            ),
          ],
        ),
      ],
    );
  }
}

class _EventSubDescription extends StatelessWidget {
  final EventState state;
  const _EventSubDescription({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Text(
          t(state.event!.sDesc!, context),
          style: Theme.of(context).textTheme.subtitle1,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _EventDescription extends StatelessWidget {
  final EventState state;
  const _EventDescription({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Text(
          t(state.event!.desc!, context),
        ),
      ],
    );
  }
}

class _EventImage extends StatelessWidget {
  final Event event;

  const _EventImage({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.4,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(64),
        ),
        child: AppNetworkImage(
          url: event.images[0],
          asCover: true,
        ),
      ),
    );
  }
}

class _EventDates extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;

  const _EventDates({
    Key? key,
    required this.startDate,
    required this.endDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${AppLocalizations.of(context)!.genStarts}: ${datetimeDayDate(startDate, context)}',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        Text(
          '${AppLocalizations.of(context)!.genEnds}: ${datetimeDayDate(endDate, context)}',
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ],
    );
  }
}

class _CountDownTimer extends StatelessWidget {
  final Duration? duration;
  final bool isOngoing;
  const _CountDownTimer({
    Key? key,
    required this.duration,
    required this.isOngoing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isOngoing) {
      return Text(
        AppLocalizations.of(context)!.contEventHomeOngoing,
        style: Theme.of(context).textTheme.headline6,
      );
    } else if (duration != null) {
      String countdownText = '';
      if (duration!.inDays == 1) {
        countdownText +=
            '${duration!.inDays} ${AppLocalizations.of(context)!.genDay} ';
      }
      if (duration!.inDays > 1) {
        countdownText +=
            '${duration!.inDays} ${AppLocalizations.of(context)!.genDays} ';
      }
      if (duration!.inHours % 24 > 0) {
        countdownText +=
            '${duration!.inHours % 24} ${AppLocalizations.of(context)!.genHourShort} ';
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            AppLocalizations.of(context)!.contEventHomeCountDown,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Text(
            countdownText,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}
