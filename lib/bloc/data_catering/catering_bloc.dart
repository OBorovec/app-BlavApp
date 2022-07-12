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
        super(CateringInitial()) {
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
    on<CateringSubscriptionFailed>(_onFailure);
    on<CateringStreamChanged>(_onCateringItemsChange);
  }

  Future<void> _onFailure(CateringSubscriptionFailed event, emit) async {
    emit(
      CateringFailState(event.message),
    );
  }

  Future<void> _onCateringItemsChange(CateringStreamChanged event, emit) async {
    try {
      emit(
        CateringLoaded(
          cateringItems: event.cateringItems,
        ),
      );
    } on Exception catch (e) {
      emit(CateringFailState(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _cateringItemsStream.cancel();
    return super.close();
  }
}
