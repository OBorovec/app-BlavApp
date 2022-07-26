import 'dart:async';

import 'package:blavapp/bloc/app/event/event_bloc.dart';
import 'package:blavapp/model/catering.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'catering_event.dart';
part 'catering_state.dart';

class CateringBloc extends Bloc<CateringEvent, CateringState> {
  final DataRepo _dataRepo;
  late final StreamSubscription<EventState> _eventFocusBlocSubscription;
  String? eventRef;
  StreamSubscription<Catering>? _cateringStream;

  CateringBloc({
    required DataRepo dataRepo,
    required EventBloc eventFocusBloc,
  })  : _dataRepo = dataRepo,
        super(const CateringState()) {
    _eventFocusBlocSubscription = eventFocusBloc.stream.listen(
        (EventState eventFocusState) =>
            createDataStream(eventTag: eventFocusState.eventTag));
    if (eventFocusBloc.state.status == EventStatus.selected) {
      createDataStream(eventTag: eventFocusBloc.state.eventTag);
    }
    // Event listeners
    on<CateringStreamChanged>(_onCateringStreamChange);
    on<CateringSubscriptionFailed>(_onCateringSubscriptionFailed);
  }

  void createDataStream({required String eventTag}) {
    eventRef = eventTag;
    if (_cateringStream != null) {
      _cateringStream!.cancel();
    }
    _cateringStream = _dataRepo.getCateringStream(eventTag).listen(
          (Catering catering) => add(
            CateringStreamChanged(
              catering: catering,
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

  Future<void> _onCateringStreamChange(
    CateringStreamChanged event,
    emit,
  ) async {
    try {
      emit(
        CateringState(
          status: CateringStatus.loaded,
          catering: event.catering,
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
        message: 'Catering: $eventRef --- ${event.message}',
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
