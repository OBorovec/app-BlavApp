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
    on<EventFocusLoad>(_initState);
    on<EventFocusChanged>(_eventFocusChange);
    on<EventFocusClear>(_clearEventFocus);
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
      final Event eventData = await _dataRepo.getEvent(
        event.eventID!,
      );
      emit(
        EventFocusState(
          status: EventFocusStatus.focused,
          eventTag: event.eventID!,
          event: eventData,
        ),
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
