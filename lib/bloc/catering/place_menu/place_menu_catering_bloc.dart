import 'dart:async';

import 'package:blavapp/model/catering.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'place_menu_catering_event.dart';
part 'place_menu_catering_state.dart';

const List<CaterItemType> menuOrder = [
  CaterItemType.starter,
  CaterItemType.soup,
  CaterItemType.main,
  CaterItemType.side,
  CaterItemType.desert,
  CaterItemType.snack,
  CaterItemType.drink,
];

class PlaceMenuCateringBloc
    extends Bloc<PlaceMenuCateringEvent, PlaceMenuCateringState> {
  final Catering catering;
  final String placeRef;
  PlaceMenuCateringBloc({
    required this.catering,
    required this.placeRef,
  }) : super(const PlaceMenuCateringState()) {
    on<UpdateMenu>(_updateMenu);
    add(const UpdateMenu());
  }

  FutureOr<void> _updateMenu(
    UpdateMenu event,
    Emitter<PlaceMenuCateringState> emit,
  ) {
    final List<CaterItem> placeItems = catering.items
        .where(
          (item) => item.placeRef == placeRef,
        )
        .toList();
    emit(PlaceMenuCateringState(
      sections: menuOrder
          .map(
            (type) => MenuSec(
              type: type,
              items: placeItems.where((item) => item.type == type).toList(),
            ),
          )
          .toList(),
    ));
  }
}
