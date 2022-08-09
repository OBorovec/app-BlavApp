import 'dart:async';

import 'package:blavapp/bloc/degustation/data_degustation/degustation_bloc.dart';
import 'package:blavapp/bloc/user_data/user_data/user_data_bloc.dart';
import 'package:blavapp/model/degustation.dart';
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
          myFavorite: userDataBloc.state.myFavorite,
          myRatings: userDataBloc.state.myRatings,
        )) {
    _degustationBlocSubscription = degustationBloc.stream.listen(
      (DegustationState state) {
        add(
          UpdateDegustation(
            desc: state.degustation.desc,
            degustationItems: state.degustationItems,
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
      headerText: event.desc,
    ));
    add(const UpdateViewData());
  }

  FutureOr<void> _updateUserData(
    UpdateUserData event,
    Emitter<HighlightDegustationState> emit,
  ) {
    emit(state.copyWith(
      myDegustationFavorite: event.myFavorite,
      myRatings: event.myRatings,
    ));
    add(const UpdateViewData());
  }

  FutureOr<void> _updateViewData(
    UpdateViewData event,
    Emitter<HighlightDegustationState> emit,
  ) {
    final Set<String> degustationRefs =
        state.degustationItems.map((DegusItem item) => item.id).toSet();
    final Set<String> myDegustationFavorite = Set.from(state.myFavorite);
    myDegustationFavorite.retainWhere(
      (String id) => degustationRefs.contains(id),
    );
    final Map<String, double> myDegustationRatings = Map.from(state.myRatings);
    myDegustationRatings.removeWhere(
      (String id, double? rating) => !degustationRefs.contains(id),
    );
    final List<DegusItem> sortedDegustationItems =
        List.from(state.degustationItems);
    sortedDegustationItems.sort(
      (DegusItem b, DegusItem a) => a.rating.compareTo(b.rating),
    );
    emit(state.copyWith(
      myDegustationFavorite: myDegustationFavorite,
      myDegustationRatings: myDegustationRatings,
      totalSamples: state.degustationItems.length,
      totalFavorites: myDegustationFavorite.length,
      totalRated: myDegustationRatings.length,
      bestRated: sortedDegustationItems.take(5).toList(),
      recommendations: const [],
    ));
  }
}
