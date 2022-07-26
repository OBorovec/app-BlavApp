import 'dart:async';
import 'package:blavapp/bloc/app/event/event_bloc.dart';
import 'package:blavapp/model/degustation.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'degustation_event.dart';
part 'degustation_state.dart';

class DegustationBloc extends Bloc<DegustationEvent, DegustationState> {
  final DataRepo _dataRepo;
  late final StreamSubscription<EventState> _eventFocusBlocSubscription;
  String? eventRef;
  StreamSubscription<Degustation>? _degustationStream;

  DegustationBloc({
    required DataRepo dataRepo,
    required EventBloc eventFocusBloc,
  })  : _dataRepo = dataRepo,
        super(const DegustationState()) {
    _eventFocusBlocSubscription = eventFocusBloc.stream.listen(
        (EventState eventFocusState) =>
            createDataStream(eventTag: eventFocusState.eventTag));
    if (eventFocusBloc.state.status == EventStatus.selected) {
      createDataStream(eventTag: eventFocusBloc.state.eventTag);
    }
    // Event listeners
    on<DegustationStreamChanged>(_onDegusItemsChange);
    on<DegustationSubscriptionFailed>(_onDegustationSubscriptionFailed);
  }

  void createDataStream({required String eventTag}) {
    eventRef = eventTag;
    if (_degustationStream != null) {
      _degustationStream!.cancel();
    }
    _degustationStream = _dataRepo.getDegustationStream(eventTag).listen(
          (Degustation degustation) => add(
            DegustationStreamChanged(
              degustation: degustation,
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

  @override
  Future<void> close() {
    _degustationStream?.cancel();
    _eventFocusBlocSubscription.cancel();
    return super.close();
  }

  Future<void> _onDegusItemsChange(
    DegustationStreamChanged event,
    emit,
  ) async {
    try {
      emit(DegustationState(
        status: DegustationStatus.loaded,
        degustation: event.degustation,
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
        message: 'Degustation: $eventRef --- ${event.message}',
      ),
    );
  }
}
