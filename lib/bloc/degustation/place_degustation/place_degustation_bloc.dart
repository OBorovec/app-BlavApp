import 'dart:async';

import 'package:blavapp/bloc/degustation/data_degustation/degustation_bloc.dart';
import 'package:blavapp/model/degustation.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'place_degustation_event.dart';
part 'place_degustation_state.dart';

const List<DegusAlcoholType> menuOrder = [
  DegusAlcoholType.mead,
];

class PlaceDegustationBloc
    extends Bloc<PlaceDegustationEvent, PlaceDegustationState> {
  late final StreamSubscription<DegustationState> _degustationBlocSubscription;

  PlaceDegustationBloc({
    required DegustationBloc degustationBloc,
  }) : super(PlaceDegustationState(
          places: convertDegustationState(degustationBloc.state),
        )) {
    _degustationBlocSubscription = degustationBloc.stream.listen(
      (DegustationState state) {
        add(
          UpdateDegusData(
            degustationState: state,
          ),
        );
      },
    );
    // Event listeners
    on<UpdateDegusData>(_updateDegusData);
  }

  static List<DegustationPlaceInfo> convertDegustationState(
    DegustationState degustationState,
  ) {
    return degustationState.degustationPlaces.entries.map((e) {
      final List<DegusItem> placeItems = degustationState.degustationItems
          .where((item) => item.placeRef == e.key)
          .toList();
      return DegustationPlaceInfo(
        items: menuOrder
            .map(
              (type) => DegustationPlaceMenuSec(
                type: type,
                items: placeItems
                    .where(
                      (item) => item.alcoholType == type,
                    )
                    .toList(),
              ),
            )
            .toList(),
        place: e.value,
      );
    }).toList();
  }

  FutureOr<void> _updateDegusData(
    UpdateDegusData event,
    Emitter<PlaceDegustationState> emit,
  ) {
    emit(PlaceDegustationState(
      places: convertDegustationState(event.degustationState),
    ));
  }

  @override
  Future<void> close() {
    _degustationBlocSubscription.cancel();
    return super.close();
  }
}
