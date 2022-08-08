import 'dart:async';

import 'package:blavapp/bloc/app/event_focus/event_focus_bloc.dart';
import 'package:blavapp/model/maps.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'maps_event.dart';
part 'maps_state.dart';

class MapsBloc extends Bloc<MapsEvent, MapsState> {
  final DataRepo _dataRepo;
  late final StreamSubscription<EventFocusState> _eventFocusBlocSubscription;
  StreamSubscription<Maps>? _mapsStream;

  MapsBloc({
    required DataRepo dataRepo,
    required EventFocusBloc eventFocusBloc,
  })  : _dataRepo = dataRepo,
        super(const MapsState()) {
    _eventFocusBlocSubscription = eventFocusBloc.stream.listen(
        (EventFocusState eventFocusState) =>
            createDataStream(eventTag: eventFocusState.eventTag));
    if (eventFocusBloc.state.status == EventFocusStatus.focused) {
      createDataStream(eventTag: eventFocusBloc.state.eventTag);
    }
    // Event listeners
    on<MapsSubscriptionFailed>(_onMapsSubscriptionFailed);
    on<MapsStreamChanged>(_onMapsChange);
  }

  void createDataStream({required String eventTag}) {
    if (_mapsStream != null) {
      _mapsStream!.cancel();
    }
    _mapsStream = _dataRepo.getMapsStream(eventTag).listen(
          (Maps maps) => add(
            MapsStreamChanged(maps: maps),
          ),
        )..onError(
        (error) {
          if (error is NullDataException) {
            add(MapsSubscriptionFailed(message: error.message));
          } else {
            add(MapsSubscriptionFailed(message: error.toString()));
          }
        },
      );
  }

  Future<void> _onMapsChange(
    MapsStreamChanged event,
    emit,
  ) async {
    try {
      emit(MapsState(
        status: MapsStatus.loaded,
        maps: event.maps,
      ));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: MapsStatus.error,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _onMapsSubscriptionFailed(
    MapsSubscriptionFailed event,
    emit,
  ) async {
    emit(
      state.copyWith(
        status: MapsStatus.error,
        message: event.message,
      ),
    );
  }

  @override
  Future<void> close() {
    _mapsStream?.cancel();
    _eventFocusBlocSubscription.cancel();
    return super.close();
  }
}
