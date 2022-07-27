import 'dart:async';

import 'package:blavapp/bloc/catering/data_catering/catering_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'highlight_catering_event.dart';
part 'highlight_catering_state.dart';

class HighlightCateringBloc
    extends Bloc<HighlightCateringEvent, HighlightCateringState> {
  late final StreamSubscription<CateringState> _cateringBlocSubscription;

  HighlightCateringBloc({
    required CateringBloc cateringBloc,
  }) : super(HighlightCateringInitial()) {
    _cateringBlocSubscription = cateringBloc.stream.listen(
      (CateringState state) {
        // add(
        //   UpdateCaterItems(
        //     cateringItems: state.cateringItems,
        //   ),
        // );
      },
    );
  }

  @override
  Future<void> close() {
    _cateringBlocSubscription.cancel();
    return super.close();
  }
}
