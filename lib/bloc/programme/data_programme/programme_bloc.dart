import 'dart:async';
import 'package:blavapp/bloc/app/event/event_bloc.dart';
import 'package:blavapp/model/programme.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'programme_event.dart';
part 'programme_state.dart';

class ProgrammeBloc extends Bloc<ProgrammeEvent, ProgrammeState> {
  final DataRepo _dataRepo;
  late final StreamSubscription<EventState> _eventFocusBlocSubscription;
  String? eventRef;
  StreamSubscription<Programme>? _programmeStream;

  ProgrammeBloc({
    required DataRepo dataRepo,
    required EventBloc eventFocusBloc,
  })  : _dataRepo = dataRepo,
        super(
          const ProgrammeState(
            status: ProgrammeStatus.initial,
            programme: Programme(),
            entries: {},
          ),
        ) {
    _eventFocusBlocSubscription = eventFocusBloc.stream.listen(
        (EventState eventFocusState) =>
            createDataStream(eventTag: eventFocusState.eventTag));
    if (eventFocusBloc.state.status == EventStatus.selected) {
      createDataStream(eventTag: eventFocusBloc.state.eventTag);
    }
    // Event listeners
    on<ProgrammeStreamChanged>(_onProgrammeStreamChanged);
    on<ProgrammeSubscriptionFailed>(_onProgrammeSubscriptionFailed);
  }

  void createDataStream({required String eventTag}) {
    eventRef = eventTag;
    if (_programmeStream != null) {
      _programmeStream!.cancel();
    }
    _programmeStream = _dataRepo
        .getProgrammeStream(eventTag)
        .listen((Programme programme) => add(
              ProgrammeStreamChanged(
                programme: programme,
              ),
            ))
      ..onError(
        (error) {
          if (error is NullDataException) {
            add(ProgrammeSubscriptionFailed(message: error.message));
          } else {
            add(ProgrammeSubscriptionFailed(message: error.toString()));
          }
        },
      );
  }

  @override
  Future<void> close() {
    _programmeStream?.cancel();
    _eventFocusBlocSubscription.cancel();
    return super.close();
  }

  Future<void> _onProgrammeStreamChanged(
      ProgrammeStreamChanged event, emit) async {
    Map<String, ProgrammeEntry> entries = {};
    for (ProgEntry entry in event.programme.entries.values) {
      for (ProgEntryRun run in entry.entryRuns.values) {
        entries[run.id] = ProgrammeEntry.structure(entry, run);
      }
    }
    emit(
      ProgrammeState(
        status: ProgrammeStatus.loaded,
        programme: event.programme,
        entries: entries,
      ),
    );
  }

  Future<void> _onProgrammeSubscriptionFailed(
      ProgrammeSubscriptionFailed event, emit) async {
    emit(
      state.copyWith(
        status: ProgrammeStatus.error,
        message: 'Programme: $eventRef --- ${event.message}',
      ),
    );
  }
}
