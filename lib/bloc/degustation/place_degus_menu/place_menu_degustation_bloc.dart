import 'dart:async';

import 'package:blavapp/model/degustation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    final List<DegusItem> placeItems = degustation.items.values
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
                  .where((DegusItem item) => item.type == type)
                  .toList(),
            ),
          )
          .toList(),
    ));
  }
}
