import 'dart:async';

import 'package:blavapp/model/cater_item.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'catering_event.dart';
part 'catering_state.dart';

class CateringBloc extends Bloc<CateringEvent, CateringState> {
  final DataRepo _dataRepo;
  late final StreamSubscription<List<CaterItem>> _cateringItemsStream;

  CateringBloc({
    required DataRepo dataRepo,
    required String eventTag,
  })  : _dataRepo = dataRepo,
        super(const CateringState(
          status: CateringStatus.initial,
        )) {
    _cateringItemsStream = _dataRepo
        .getCaterItemsStream(eventTag)
        .listen((List<CaterItem> cateringItems) => add(
              CateringStreamChanged(
                cateringItems: cateringItems,
              ),
            ))
      ..onError(
        (error) {
          add(CateringSubscriptionFailed(error.toString()));
        },
      );
    // Event listeners
    on<CateringSubscriptionFailed>(_onCateringSubscriptionFailed);
    on<CateringStreamChanged>(_onCateringItemsChange);
  }

  Future<void> _onCateringItemsChange(CateringStreamChanged event, emit) async {
    try {
      final Set<CaterItemType> availableItemTypes = <CaterItemType>{};
      final Set<String?> availablePlaces = <String>{};
      for (final CaterItem item in event.cateringItems) {
        availableItemTypes.add(item.type);
        availablePlaces.add(item.placeRef);
      }
      emit(
        CateringState(
          status: CateringStatus.loaded,
          cateringItems: event.cateringItems,
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
      CateringSubscriptionFailed event, emit) async {
    emit(
      state.copyWith(
        status: CateringStatus.failed,
        message: event.toString(),
      ),
    );
  }

  @override
  Future<void> close() {
    _cateringItemsStream.cancel();
    return super.close();
  }
}
