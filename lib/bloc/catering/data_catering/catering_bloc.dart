import 'dart:async';

import 'package:blavapp/model/catering.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'catering_event.dart';
part 'catering_state.dart';

class CateringBloc extends Bloc<CateringEvent, CateringState> {
  final DataRepo _dataRepo;
  late final StreamSubscription<Catering> _cateringStream;

  CateringBloc({
    required DataRepo dataRepo,
    required String eventTag,
  })  : _dataRepo = dataRepo,
        super(const CateringState()) {
    _cateringStream = _dataRepo.getCateringStream(eventTag).listen(
          (Catering catering) => add(
            CateringStreamChanged(
              cateringItems: catering.items,
              cateringPlaces: catering.places,
              cateringNotifications: catering.notifications,
            ),
          ),
          // )..onError(
          // (error) {
          //   add(CateringSubscriptionFailed(error.toString()));
          // },
        );
    // Event listeners
    on<CateringSubscriptionFailed>(_onCateringSubscriptionFailed);
    on<CateringStreamChanged>(_onCateringItemsChange);
  }

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
          status: CateringStatus.failed,
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
        status: CateringStatus.failed,
        message: event.toString(),
      ),
    );
  }

  @override
  Future<void> close() {
    _cateringStream.cancel();
    return super.close();
  }
}
