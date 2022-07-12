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
        super(const NoEventFocus()) {
    on<EventFocusLoad>(_loadEventFocus);
    on<EventFocusChanged>(_eventFocusChange);
    on<EventFocusClear>(_clearEventFocus);
  }

  Future<void> _eventFocusChange(EventFocusChanged event, emit) async {
    _prefs.saveEventFocus(event.eventID ?? '');
    if (event.eventID == null || event.eventID == '') {
      emit(const NoEventFocus());
    } else {
      final Event eventInfo = await _dataRepo.getEvent(
        event.eventID!,
      );
      emit(
        EventFocused(
          event.eventID!,
          eventInfo,
        ),
      );
    }
  }

  Future<void> _loadEventFocus(EventFocusLoad event, emit) async {
    final String? eventID = _prefs.loadEventFocus();
    add(EventFocusChanged(eventID: eventID));
  }

  Future<void> _clearEventFocus(_, emit) async {
    add(const EventFocusChanged(eventID: null));
  }
}
