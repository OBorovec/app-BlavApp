import 'dart:async';

import 'package:blavapp/bloc/catering/data_catering/catering_bloc.dart';
import 'package:blavapp/model/catering.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'places_catering_event.dart';
part 'places_catering_state.dart';

const List<CaterItemType> menuOrder = [
  CaterItemType.starter,
  CaterItemType.soup,
  CaterItemType.main,
  CaterItemType.side,
  CaterItemType.desert,
  CaterItemType.snack,
  CaterItemType.drink,
];

class PlacesCateringBloc
    extends Bloc<PlacesCateringEvent, PlacesCateringState> {
  late final StreamSubscription<CateringState> _cateringBlocSubscription;

  PlacesCateringBloc({
    required CateringBloc cateringBloc,
  }) : super(PlacesCateringState(
          places: convertCateringState(cateringBloc.state),
        )) {
    _cateringBlocSubscription = cateringBloc.stream.listen(
      (CateringState state) {
        add(
          UpdateCaterData(
            cateringState: state,
          ),
        );
      },
    );
    // Event listeners
    on<UpdateCaterData>(_updateCaterData);
  }

  static List<CateringPlaceInfo> convertCateringState(
    CateringState cateringState,
  ) {
    return cateringState.cateringPlaces.entries.map((e) {
      final List<CaterItem> placeItems = cateringState.cateringItems
          .where((item) => item.placeRef == e.key)
          .toList();

      return CateringPlaceInfo(
        items: menuOrder
            .map(
              (type) => CateringPlaceMenuSec(
                type: type,
                items: placeItems
                    .where(
                      (item) => item.type == type,
                    )
                    .toList(),
              ),
            )
            .toList(),
        place: e.value,
      );
    }).toList();
  }

  FutureOr<void> _updateCaterData(
    UpdateCaterData event,
    Emitter<PlacesCateringState> emit,
  ) {
    emit(PlacesCateringState(
      places: convertCateringState(event.cateringState),
    ));
  }

  @override
  Future<void> close() {
    _cateringBlocSubscription.cancel();
    return super.close();
  }
}
