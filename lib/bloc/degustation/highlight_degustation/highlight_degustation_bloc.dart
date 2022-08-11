import 'dart:async';

import 'package:blavapp/bloc/degustation/data_degustation/degustation_bloc.dart';
import 'package:blavapp/bloc/user_data/user_data/user_data_bloc.dart';
import 'package:blavapp/model/degustation.dart';
import 'package:blavapp/utils/model_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'highlight_degustation_event.dart';
part 'highlight_degustation_state.dart';

class HighlightDegustationBloc
    extends Bloc<HighlightDegustationEvent, HighlightDegustationState> {
  late final StreamSubscription<DegustationState> _degustationBlocSubscription;
  late final StreamSubscription<UserDataState> _userDataBlocSubscription;
  HighlightDegustationBloc({
    required DegustationBloc degustationBloc,
    required UserDataBloc userDataBloc,
  }) : super(HighlightDegustationState(
          headerText: degustationBloc.state.degustation.desc,
          degustationItems: degustationBloc.state.degustationItems,
          degustationPlaces: degustationBloc.state.degustationPlaces,
          myFavorite: userDataBloc.state.myFavorite,
          myRatings: userDataBloc.state.myRatings,
        )) {
    _degustationBlocSubscription = degustationBloc.stream.listen(
      (DegustationState state) {
        add(
          UpdateDegustation(
            desc: state.degustation.desc,
            degustationItems: state.degustationItems,
            degustationPlaces: state.degustationPlaces,
          ),
        );
      },
    );
    _userDataBlocSubscription = userDataBloc.stream.listen(
      (UserDataState state) => add(
        UpdateUserData(
          myFavorite: state.myFavorite,
          myRatings: state.myRatings,
        ),
      ),
    );
    // Event listeners
    on<UpdateDegustation>(_updateDegustation);
    on<UpdateUserData>(_updateUserData);
    on<UpdateViewData>(_updateViewData);
    // Initialise view data
    add(const UpdateViewData());
  }

  @override
  Future<void> close() {
    _degustationBlocSubscription.cancel();
    _userDataBlocSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _updateDegustation(
    UpdateDegustation event,
    Emitter<HighlightDegustationState> emit,
  ) {
    emit(state.copyWith(
      degustationItems: event.degustationItems,
      degustationPlaces: event.degustationPlaces,
      headerText: event.desc,
    ));
    add(const UpdateViewData());
  }

  FutureOr<void> _updateUserData(
    UpdateUserData event,
    Emitter<HighlightDegustationState> emit,
  ) {
    emit(state.copyWith(
      myFavorite: event.myFavorite,
      myRatings: event.myRatings,
    ));
    add(const UpdateViewData());
  }

  FutureOr<void> _updateViewData(
    UpdateViewData event,
    Emitter<HighlightDegustationState> emit,
  ) {
    // Set of all degustation item IDs
    final Set<String> degustationRefs =
        state.degustationItems.map((DegusItem item) => item.id).toSet();
    // Set of user favorite degustation item IDs
    final Set<String> myDegustationFavorite = Set.from(state.myFavorite);
    myDegustationFavorite.retainWhere(
      (String id) => degustationRefs.contains(id),
    );
    // Subset of user relevant rating
    final Map<String, double> myDegustationRatings = Map.from(state.myRatings);
    myDegustationRatings.removeWhere(
      (String id, double? rating) => !degustationRefs.contains(id),
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
          (DegusItem item) => state.myFavorite.contains(item.id),
        )
        .toList();
    final Set<DegusItem> similarToLikedItems = {};
    for (DegusItem item in myFavoriteItems) {
      for (String simItemRef in item.similarItems) {
        try {
          final DegusItem simItem = state.degustationItems
              .where((DegusItem i) =>
                  i.id == simItemRef && !state.myFavorite.contains(i.id))
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
      myDegustationFavorite: myDegustationFavorite,
      myDegustationRatings: myDegustationRatings,
      totalSamples: state.degustationItems.length,
      totalFavorites: myDegustationFavorite.length,
      totalRated: myDegustationRatings.length,
      placeCardData: placeCardData,
      bestRated: sortedDegustationItems.take(5).toList(),
      similarToLiked: similarToLikedItemsList.take(5).toList(),
      recommendations: const [],
    ));
  }
}
