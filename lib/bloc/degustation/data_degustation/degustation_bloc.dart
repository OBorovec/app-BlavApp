import 'dart:async';
import 'package:blavapp/bloc/app_state/event_focus/event_focus_bloc.dart';
import 'package:blavapp/model/degustation.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'degustation_event.dart';
part 'degustation_state.dart';

class DegustationBloc extends Bloc<DegustationEvent, DegustationState> {
  final DataRepo _dataRepo;
  late final StreamSubscription<EventFocusState> _eventFocusBlocSubscription;
  StreamSubscription<Degustation>? _degustationStream;

  DegustationBloc({
    required DataRepo dataRepo,
    required EventFocusBloc eventFocusBloc,
  })  : _dataRepo = dataRepo,
        super(const DegustationState()) {
    _eventFocusBlocSubscription = eventFocusBloc.stream.listen(
        (EventFocusState eventFocusState) =>
            createDataStream(eventTag: eventFocusState.eventTag));
    if (eventFocusBloc.state.status == EventFocusStatus.focused) {
      createDataStream(eventTag: eventFocusBloc.state.eventTag);
    }
    // Event listeners
    on<DegustationSubscriptionFailed>(_onDegustationSubscriptionFailed);
    on<DegustationStreamChanged>(_onDegusItemsChange);
  }

  void createDataStream({required String eventTag}) {
    if (_degustationStream != null) {
      _degustationStream!.cancel();
    }
    _degustationStream = _dataRepo.getDegustationStream(eventTag).listen(
          (Degustation degustation) => add(
            DegustationStreamChanged(
              degustationItems: degustation.items,
              degustationPlaces: degustation.places,
              degustationNotifications: degustation.notifications,
            ),
          ),
        )..onError(
        (error) {
          if (error is NullDataException) {
            add(DegustationSubscriptionFailed(message: error.message));
          } else {
            add(DegustationSubscriptionFailed(message: error.toString()));
          }
        },
      );
  }

  Future<void> _onDegusItemsChange(
    DegustationStreamChanged event,
    emit,
  ) async {
    try {
      emit(DegustationState(
        status: DegustationStatus.loaded,
        degustationItems: event.degustationItems,
        degustationPlaces: event.degustationPlaces,
        notifications: event.degustationNotifications,
      ));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: DegustationStatus.error,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _onDegustationSubscriptionFailed(
    DegustationSubscriptionFailed event,
    emit,
  ) async {
    emit(
      state.copyWith(
        status: DegustationStatus.error,
        message: event.message,
      ),
    );
  }

  @override
  Future<void> close() {
    _degustationStream?.cancel();
    _eventFocusBlocSubscription.cancel();
    return super.close();
  }
}
