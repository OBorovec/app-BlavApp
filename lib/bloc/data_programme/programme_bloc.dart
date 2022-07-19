import 'dart:async';
import 'package:blavapp/model/prog_entry.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'programme_event.dart';
part 'programme_state.dart';

class ProgrammeBloc extends Bloc<ProgrammeEvent, ProgrammeState> {
  final DataRepo _dataRepo;
  late final StreamSubscription<List<ProgEntry>> _programmeEntries;

  ProgrammeBloc({
    required DataRepo dataRepo,
    required String eventTag,
  })  : _dataRepo = dataRepo,
        super(
          const ProgrammeState(status: ProgrammeStatus.initial),
        ) {
    _programmeEntries = _dataRepo
        .getProgItemsStream(eventTag)
        .listen((List<ProgEntry> programmeEntries) => add(
              ProgrammeStreamChanged(
                programmeEntries: programmeEntries,
              ),
            ))
      ..onError((error) {
        add(ProgrammeSubscriptionFailed(error.toString()));
      });
    // Event listeners
    on<ProgrammeStreamChanged>(_onProgrammeStreamChanged);
    on<ProgrammeSubscriptionFailed>(_onProgrammeSubscriptionFailed);
  }

  Future<void> _onProgrammeStreamChanged(
      ProgrammeStreamChanged event, emit) async {
    try {
      emit(
        ProgrammeState(
          status: ProgrammeStatus.loaded,
          programmeEntries: event.programmeEntries,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: ProgrammeStatus.failed,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _onProgrammeSubscriptionFailed(
      ProgrammeSubscriptionFailed event, emit) async {
    emit(
      state.copyWith(
        status: ProgrammeStatus.failed,
        message: event.message,
      ),
    );
  }

  @override
  Future<void> close() {
    _programmeEntries.cancel();
    return super.close();
  }
}
