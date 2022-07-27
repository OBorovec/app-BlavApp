import 'dart:async';
import 'package:blavapp/model/degustation.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'degustation_event.dart';
part 'degustation_state.dart';

class DegustationBloc extends Bloc<DegustationEvent, DegustationState> {
  final DataRepo _dataRepo;
  late final StreamSubscription<Degustation> _degustationItemsStream;

  DegustationBloc({
    required DataRepo dataRepo,
    required String eventTag,
  })  : _dataRepo = dataRepo,
        super(const DegustationState()) {
    _degustationItemsStream = _dataRepo.getDegustationStream(eventTag).listen(
          (Degustation degustation) => add(
            DegustationStreamChanged(
              degustationItems: degustation.items,
              degustationPlaces: degustation.places,
              degustationNotifications: degustation.notifications,
            ),
          ),
          // )..onError(
          // (error) {
          //   add(DegustationSubscriptionFailed(error.toString()));
          // },
        );
    // Event listeners
    on<DegustationSubscriptionFailed>(_onDegustationSubscriptionFailed);
    on<DegustationStreamChanged>(_onDegusItemsChange);
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
          status: DegustationStatus.failed,
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
        status: DegustationStatus.failed,
        message: event.toString(),
      ),
    );
  }

  @override
  Future<void> close() {
    _degustationItemsStream.cancel();
    return super.close();
  }
}
