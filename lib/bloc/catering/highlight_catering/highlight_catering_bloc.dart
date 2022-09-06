import 'dart:async';

import 'package:blavapp/bloc/catering/data_catering/catering_bloc.dart';
import 'package:blavapp/bloc/user_data/user_data/user_data_bloc.dart';
import 'package:blavapp/model/catering.dart';
import 'package:blavapp/utils/model_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'highlight_catering_event.dart';
part 'highlight_catering_state.dart';

class HighlightCateringBloc
    extends Bloc<HighlightCateringEvent, HighlightCateringState> {
  late final StreamSubscription<CateringState> _cateringBlocSubscription;
  late final StreamSubscription<UserDataState> _userDataBlocSubscription;

  HighlightCateringBloc({
    required CateringBloc cateringBloc,
    required UserDataBloc userDataBloc,
  }) : super(HighlightCateringState(
          headerText: cateringBloc.state.catering.desc,
          mealItems: cateringBloc.state.mealItems,
          cateringPlaces: cateringBloc.state.cateringPlaces,
          myFavorite: userDataBloc.state.myFavorite,
        )) {
    _cateringBlocSubscription = cateringBloc.stream.listen(
      (CateringState state) {
        add(
          UpdateCatering(
            mealItems: state.mealItems,
            caterPlaces: state.cateringPlaces,
          ),
        );
      },
    );
    _userDataBlocSubscription = userDataBloc.stream.listen(
      (UserDataState state) => add(
        UpdateUserData(
          myFavorite: state.myFavorite,
        ),
      ),
    );
    // Event listeners
    on<UpdateCatering>(_updateCatering);
    on<UpdateUserData>(_updateUserData);
    on<UpdateViewData>(_updateViewData);
    // Initialise view data
    add(const UpdateViewData());
  }

  @override
  Future<void> close() {
    _cateringBlocSubscription.cancel();
    _userDataBlocSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _updateCatering(
    UpdateCatering event,
    Emitter<HighlightCateringState> emit,
  ) {
    emit(state.copyWith(
      cateringItems: event.mealItems,
      headerText: event.desc,
    ));
    add(const UpdateViewData());
  }

  FutureOr<void> _updateUserData(
    UpdateUserData event,
    Emitter<HighlightCateringState> emit,
  ) {
    emit(state.copyWith(
      myFavorite: event.myFavorite,
    ));
    add(const UpdateViewData());
  }

  FutureOr<void> _updateViewData(
    UpdateViewData event,
    Emitter<HighlightCateringState> emit,
  ) {
    final List<HighlightPlaceCardData> placeCardData = [];
    state.cateringPlaces.forEach((String id, CaterPlace place) {
      placeCardData.add(
        HighlightPlaceCardData(
          place: place,
          isOpen: place.open != null ? isOpenCal(place.open!) : false,
        ),
      );
    });
    emit(state.copyWith(
      totalItems: state.mealItems.length,
      totalPlaces: state.cateringPlaces.length,
      placeCardData: placeCardData,
    ));
  }
}
