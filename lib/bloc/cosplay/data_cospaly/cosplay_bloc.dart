import 'dart:async';

import 'package:blavapp/bloc/app/event_focus/event_focus_bloc.dart';
import 'package:blavapp/model/cosplay.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cosplay_event.dart';
part 'cosplay_state.dart';

class CosplayBloc extends Bloc<CosplayEvent, CosplayState> {
  final DataRepo _dataRepo;
  late final StreamSubscription<EventFocusState> _eventFocusBlocSubscription;
  String? eventRef;
  StreamSubscription<Cosplay>? _cosplayStream;

  CosplayBloc({
    required DataRepo dataRepo,
    required EventFocusBloc eventFocusBloc,
  })  : _dataRepo = dataRepo,
        super(const CosplayState()) {
    _eventFocusBlocSubscription = eventFocusBloc.stream.listen(
        (EventFocusState eventFocusState) =>
            createDataStream(eventTag: eventFocusState.eventTag));
    if (eventFocusBloc.state.status == EventFocusStatus.focused) {
      createDataStream(eventTag: eventFocusBloc.state.eventTag);
    }
    // Event listeners
    on<CosplaySubscriptionFailed>(_onCosplaySubscriptionFailed);
    on<CosplayStreamChanged>(_onCosplayItemsChange);
  }

  void createDataStream({required String eventTag}) {
    eventRef = eventTag;
    if (_cosplayStream != null) {
      _cosplayStream!.cancel();
    }
    _cosplayStream = _dataRepo.getCosplayStream(eventTag).listen(
          (Cosplay cosplay) => add(
            CosplayStreamChanged(
              cosplay: cosplay,
            ),
          ),
        )..onError(
        (error) {
          if (error is NullDataException) {
            add(CosplaySubscriptionFailed(message: error.message));
          } else {
            add(CosplaySubscriptionFailed(message: error.toString()));
          }
        },
      );
  }

  FutureOr<void> _onCosplayItemsChange(
    CosplayStreamChanged event,
    Emitter<CosplayState> emit,
  ) {
    try {
      emit(CosplayState(
        status: CosplayStatus.loaded,
        cosplay: event.cosplay,
      ));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: CosplayStatus.error,
          message: e.toString(),
        ),
      );
    }
  }

  FutureOr<void> _onCosplaySubscriptionFailed(
    CosplaySubscriptionFailed event,
    Emitter<CosplayState> emit,
  ) {
    emit(
      CosplayState(
        status: CosplayStatus.error,
        message: 'Cosplay: $eventRef --- ${event.message}',
      ),
    );
  }

  @override
  Future<void> close() {
    _cosplayStream?.cancel();
    _eventFocusBlocSubscription.cancel();
    return super.close();
  }
}
