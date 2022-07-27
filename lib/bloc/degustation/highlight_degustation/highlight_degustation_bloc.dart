import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'highlight_degustation_event.dart';
part 'highlight_degustation_state.dart';

class HighlightDegustationBloc extends Bloc<HighlightDegustationEvent, HighlightDegustationState> {
  HighlightDegustationBloc() : super(HighlightDegustationInitial()) {
    on<HighlightDegustationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
