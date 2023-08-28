import 'dart:async';

import 'package:blavapp/bloc/degustation/data_degustation/degustation_bloc.dart';
import 'package:blavapp/bloc/user_data/local_user_data/local_user_data_bloc.dart';
import 'package:blavapp/bloc/user_data/user_data/user_data_bloc.dart';
import 'package:blavapp/model/degustation.dart';
import 'package:blavapp/utils/model_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'highlight_degustation_event.dart';
part 'highlight_degustation_state.dart';

class HighlightDegustationBloc
    extends Bloc<HighlightDegustationEvent, HighlightDegustationState> {
  late final StreamSubscription<DegustationState> _degustationBlocSubscription;
  late final StreamSubscription<UserDataState> _userDataBlocSubscription;
  late final StreamSubscription<LocalUserDataState>
      _localUserDataBlocSubscription;
  HighlightDegustationBloc({
    required DegustationBloc degustationBloc,
    required UserDataBloc userDataBloc,
    required LocalUserDataBloc localUserDataBloc,
  }) : super(HighlightDegustationState(
          headerText: degustationBloc.state.degustation.desc,
          degustationItems: degustationBloc.state.degustationItems,
          degustationPlaces: degustationBloc.state.degustationPlaces,
          userFavorite: userDataBloc.state.myFavorite,
          userRatings: userDataBloc.state.myRatings,
          userTasted: localUserDataBloc.state.tastedDegustations,
        )) {
    _degustationBlocSubscription = degustationBloc.stream.listen(
      (DegustationState state) {
        add(
          UpdateDegustation(
            headerText: state.degustation.desc,
            degustationItems: state.degustationItems,
            degustationPlaces: state.degustationPlaces,
          ),
        );
      },
    );
    _userDataBlocSubscription = userDataBloc.stream.listen(
      (UserDataState state) => add(
        UpdateUserData(
          userFavorite: state.myFavorite,
          userRatings: state.myRatings,
        ),
      ),
    );
    _localUserDataBlocSubscription = localUserDataBloc.stream.listen(
      (LocalUserDataState state) => add(
        UpdateLocalUserData(
          userTasted: state.tastedDegustations,
        ),
      ),
    );
    // Event listeners
    on<UpdateDegustation>(_updateDegustation);
    on<UpdateUserData>(_updateUserData);
    on<UpdateLocalUserData>(_updateLocalUserData);
    on<CalculateViewData>(_calculateViewData);
    // Initialise view data
    add(const CalculateViewData());
  }

  @override
  Future<void> close() {
    _degustationBlocSubscription.cancel();
    _userDataBlocSubscription.cancel();
    _localUserDataBlocSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _updateDegustation(
    UpdateDegustation event,
    Emitter<HighlightDegustationState> emit,
  ) {
    emit(state.copyWith(
      degustationItems: event.degustationItems,
      degustationPlaces: event.degustationPlaces,
      headerText: event.headerText,
    ));
    add(const CalculateViewData());
  }

  FutureOr<void> _updateUserData(
    UpdateUserData event,
    Emitter<HighlightDegustationState> emit,
  ) {
    emit(state.copyWith(
      userFavorite: event.userFavorite,
      userRatings: event.userRatings,
    ));
    add(const CalculateViewData());
  }

  FutureOr<void> _updateLocalUserData(
    UpdateLocalUserData event,
    Emitter<HighlightDegustationState> emit,
  ) {
    emit(state.copyWith(
      userTasted: event.userTasted,
    ));
    add(const CalculateViewData());
  }

  FutureOr<void> _calculateViewData(
    CalculateViewData event,
    Emitter<HighlightDegustationState> emit,
  ) {
    // Get all degustation item IDs
    final Set<String> itemRefs =
        state.degustationItems.map((DegusItem item) => item.id).toSet();
    // Get relevant user tasted degustation item IDs
    final Set<String> userTasted = Set.from(state.userTasted);
    userTasted.retainWhere(
      (String id) => itemRefs.contains(id),
    );
    // Get user favorite degustation item IDs
    final Set<String> userFavorite = Set.from(state.userFavorite);
    userFavorite.retainWhere(
      (String id) => itemRefs.contains(id),
    );
    // Subset of user relevant rating
    final Map<String, double> userRatings = Map.from(state.userRatings);
    userRatings.removeWhere(
      (String id, double? rating) => !itemRefs.contains(id),
    );
    // Data for degustation place highlights
    final List<HighlightPlaceCardData> placeCardData = [];
    state.degustationPlaces.forEach((String id, DegusPlace place) {
      placeCardData.add(
        HighlightPlaceCardData(
          place: place,
          isOpen: place.open != null ? isOpenCal(place.open!) : false,
        ),
      );
    });
    // Data for the best rated samples
    final List<DegusItem> sortedDegustationItems =
        List.from(state.degustationItems);
    sortedDegustationItems.sort(
      (DegusItem b, DegusItem a) => a.rating.compareTo(b.rating),
    );
    final List<DegusItem> myFavoriteItems = state.degustationItems
        .where(
          (DegusItem item) => state.userFavorite.contains(item.id),
        )
        .toList();
    final Set<DegusItem> similarToLikedItems = {};
    for (DegusItem item in myFavoriteItems) {
      for (String simItemRef in item.similarItems) {
        try {
          final DegusItem simItem = state.degustationItems
              .where((DegusItem i) =>
                  i.id == simItemRef && !state.userFavorite.contains(i.id))
              .first;
          similarToLikedItems.add(simItem);
        } catch (e) {
          // TODO: fix it to not use ty-catch
        }
      }
    }
    final List<DegusItem> similarToLikedItemsList =
        similarToLikedItems.toList();
    similarToLikedItemsList.shuffle();
    emit(state.copyWith(
      myDegustationFavorite: userFavorite,
      myDegustationRatings: userRatings,
      totalSamples: state.degustationItems.length,
      totalTasted: userTasted.length,
      totalFavorites: userFavorite.length,
      totalRated: userRatings.length,
      placeCardData: placeCardData,
      bestRated: sortedDegustationItems.take(5).toList(),
      similarToLiked: similarToLikedItemsList.take(5).toList(),
      recommendations: const [],
    ));
  }
}
