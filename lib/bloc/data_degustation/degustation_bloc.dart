import 'dart:async';
import 'package:blavapp/model/degus_item.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'degustation_event.dart';
part 'degustation_state.dart';

class DegustationBloc extends Bloc<DegustationEvent, DegustationState> {
  final DataRepo _dataRepo;
  late final StreamSubscription<List<DegusItem>> _degustationItemsStream;

  DegustationBloc({
    required DataRepo dataRepo,
    required String eventTag,
  })  : _dataRepo = dataRepo,
        super(DegustationInitial()) {
    _degustationItemsStream = _dataRepo
        .getDegusItemsStream(eventTag)
        .listen((List<DegusItem> degustationItems) => add(
              DegustationStreamChanged(
                degustationItems: degustationItems,
              ),
            ))
      ..onError((error) {
        add(DegustationSubscriptionFailed(error.toString()));
      });
    // Event listeners
    on<DegustationSubscriptionFailed>(_onFailure);
    on<DegustationStreamChanged>(_onDegusItemsChange);
  }

  Future<void> _onFailure(DegustationSubscriptionFailed event, emit) async {
    emit(
      DegustationFailState(event.message),
    );
  }

  Future<void> _onDegusItemsChange(DegustationStreamChanged event, emit) async {
    try {
      emit(
        DegustationLoaded(
          degustationItems: event.degustationItems,
        ),
      );
    } on Exception catch (e) {
      emit(DegustationFailState(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _degustationItemsStream.cancel();
    return super.close();
  }
}
