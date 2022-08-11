import 'dart:async';

import 'package:blavapp/model/degustation.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'place_menu_degustation_event.dart';
part 'place_menu_degustation_state.dart';

const List<DegusAlcoholType> menuOrder = [
  DegusAlcoholType.mead,
];

class PlaceMenuDegustationBloc
    extends Bloc<PlaceMenuDegustationEvent, PlaceMenuDegustationState> {
  final Degustation degustation;
  final String placeRef;

  PlaceMenuDegustationBloc({
    required this.degustation,
    required this.placeRef,
  }) : super(const PlaceMenuDegustationState()) {
    on<UpdateMenu>(_updateMenu);
    add(const UpdateMenu());
  }

  FutureOr<void> _updateMenu(
    UpdateMenu event,
    Emitter<PlaceMenuDegustationState> emit,
  ) {
    final List<DegusItem> placeItems = degustation.items
        .where(
          (DegusItem item) => item.placeRef.contains(placeRef),
        )
        .toList();
    emit(PlaceMenuDegustationState(
      sections: menuOrder
          .map(
            (type) => MenuSec(
              type: type,
              items: placeItems
                  .where((DegusItem item) => item.alcoholType == type)
                  .toList(),
            ),
          )
          .toList(),
    ));
  }
}
