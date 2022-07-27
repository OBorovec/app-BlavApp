import 'dart:async';

import 'package:blavapp/model/maps.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'maps_event.dart';
part 'maps_state.dart';

class MapsBloc extends Bloc<MapsEvent, MapsState> {
  final DataRepo _dataRepo;
  late final StreamSubscription<Maps> _mapsStream;

  MapsBloc({
    required DataRepo dataRepo,
    required String eventTag,
  })  : _dataRepo = dataRepo,
        super(const MapsState()) {
    _mapsStream = _dataRepo.getMapsStream(eventTag).listen(
          (Maps maps) => add(
            MapsStreamChanged(
              mapRecords: maps.mapRecords,
              realWorldRecords: maps.realWorldRecords,
            ),
          ),
          // )..onError(
          // (error) {
          //   add(DegustationSubscriptionFailed(error.toString()));
          // },
        );
    // Event listeners
    on<MapsSubscriptionFailed>(_onMapsSubscriptionFailed);
    on<MapsStreamChanged>(_onMapsChange);
  }

  Future<void> _onMapsChange(
    MapsStreamChanged event,
    emit,
  ) async {
    try {
      emit(MapsState(
        status: DataStatus.loaded,
        mapRecords: event.mapRecords,
        realWorldRecords: event.realWorldRecords,
      ));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: DataStatus.failed,
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
        status: DataStatus.failed,
        message: event.toString(),
      ),
    );
  }

  @override
  Future<void> close() {
    _mapsStream.cancel();
    return super.close();
  }
}
