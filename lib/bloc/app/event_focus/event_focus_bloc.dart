import 'dart:async';

import 'package:blavapp/model/event.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:blavapp/services/prefs_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'event_focus_event.dart';
part 'event_focus_state.dart';

class EventFocusBloc extends Bloc<EventFocus, EventFocusState> {
  final PrefsRepo _prefs;
  final DataRepo _dataRepo;
  StreamSubscription<Event>? _eventStream;

  EventFocusBloc({
    required PrefsRepo prefs,
    required DataRepo dataRepo,
  })  : _prefs = prefs,
        _dataRepo = dataRepo,
        super(const EventFocusState(
          status: EventFocusStatus.empty,
          eventTag: '',
          event: null,
        )) {
    // Stream listeners
    on<EventStreamChanged>(_onEventStreamChange);
    on<EventSubscriptionFailed>(_onEventSubscriptionFailed);
    // Event listeners
    on<EventFocusLoad>(_initState);
    on<EventFocusChanged>(_eventFocusChange);
    on<EventFocusClear>(_clearEventFocus);
  }

  FutureOr<void> _onEventStreamChange(
    EventStreamChanged event,
    Emitter<EventFocusState> emit,
  ) {
    final Event eventData = event.event;
    emit(EventFocusState(
      status: EventFocusStatus.focused,
      eventTag: eventData.id,
      event: eventData,
      remainingToStart: DateTime.now().isBefore(eventData.dayStart)
          ? eventData.dayStart.difference(DateTime.now())
          : null,
      isOngoing: DateTime.now().isAfter(eventData.dayStart) &&
          DateTime.now().isBefore(eventData.dayEnd),
    ));
  }

  FutureOr<void> _onEventSubscriptionFailed(
    EventSubscriptionFailed event,
    Emitter<EventFocusState> emit,
  ) {
    emit(const EventFocusState(
      status: EventFocusStatus.empty,
      eventTag: '',
    ));
  }

  @override
  Future<void> close() {
    _eventStream?.cancel();
    return super.close();
  }

  Future<void> _eventFocusChange(EventFocusChanged event, emit) async {
    _prefs.saveEventFocus(event.eventID ?? '');
    if (event.eventID == null || event.eventID == '') {
      emit(const EventFocusState(
        status: EventFocusStatus.empty,
        eventTag: '',
        event: null,
      ));
    } else {
      if (_eventStream != null) {
        _eventStream!.cancel();
      }
      _eventStream = _dataRepo.getEventStream(event.eventID!).listen(
            (Event event) => add(
              EventStreamChanged(
                event: event,
              ),
            ),
          )..onError(
          (error) {
            if (error is NullDataException) {
              add(EventSubscriptionFailed(message: error.message));
            } else {
              add(EventSubscriptionFailed(message: error.toString()));
            }
          },
        );
    }
  }

  Future<void> _initState(EventFocusLoad event, emit) async {
    final String? eventID = _prefs.loadEventFocus();
    add(EventFocusChanged(eventID: eventID));
  }

  Future<void> _clearEventFocus(_, emit) async {
    add(const EventFocusChanged(eventID: null));
  }
}
