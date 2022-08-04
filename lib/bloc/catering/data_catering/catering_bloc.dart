import 'dart:async';

import 'package:blavapp/bloc/app_state/event_focus/event_focus_bloc.dart';
import 'package:blavapp/model/catering.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'catering_event.dart';
part 'catering_state.dart';

class CateringBloc extends Bloc<CateringEvent, CateringState> {
  final DataRepo _dataRepo;
  late final StreamSubscription<EventFocusState> _eventFocusBlocSubscription;
  StreamSubscription<Catering>? _cateringStream;

  CateringBloc({
    required DataRepo dataRepo,
    required EventFocusBloc eventFocusBloc,
  })  : _dataRepo = dataRepo,
        super(const CateringState()) {
    _eventFocusBlocSubscription = eventFocusBloc.stream.listen(
        (EventFocusState eventFocusState) =>
            createDataStream(eventTag: eventFocusState.eventTag));
    if (eventFocusBloc.state.status == EventFocusStatus.focused) {
      createDataStream(eventTag: eventFocusBloc.state.eventTag);
    }
    // Event listeners
    on<CateringSubscriptionFailed>(_onCateringSubscriptionFailed);
    on<CateringStreamChanged>(_onCateringItemsChange);
  }

  void createDataStream({required String eventTag}) {
    if (_cateringStream != null) {
      _cateringStream!.cancel();
    }
    _cateringStream = _dataRepo.getCateringStream(eventTag).listen(
          (Catering catering) => add(
            CateringStreamChanged(
              cateringItems: catering.items,
              cateringPlaces: catering.places,
              cateringNotifications: catering.notifications,
            ),
          ),
        )..onError(
        (error) {
          if (error is NullDataException) {
            add(CateringSubscriptionFailed(message: error.message));
          } else {
            add(CateringSubscriptionFailed(message: error.toString()));
          }
        },
      );
  }

  // Event listeners implementations

  Future<void> _onCateringItemsChange(
    CateringStreamChanged event,
    emit,
  ) async {
    try {
      emit(
        CateringState(
          status: CateringStatus.loaded,
          cateringItems: event.cateringItems,
          cateringPlaces: event.cateringPlaces,
          notifications: event.cateringNotifications,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: CateringStatus.error,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _onCateringSubscriptionFailed(
    CateringSubscriptionFailed event,
    emit,
  ) async {
    emit(
      state.copyWith(
        status: CateringStatus.error,
        message: event.message,
      ),
    );
  }

  @override
  Future<void> close() {
    _cateringStream?.cancel();
    _eventFocusBlocSubscription.cancel();
    return super.close();
  }
}
