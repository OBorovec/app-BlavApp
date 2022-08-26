import 'dart:async';

import 'package:blavapp/bloc/admin/voting_data/voting_data_bloc.dart';
import 'package:blavapp/model/cosplay.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'voting_results_event.dart';
part 'voting_results_state.dart';

class VotingResultsBloc extends Bloc<VotingResultsEvent, VotingResultsState> {
  late final StreamSubscription<VotingDataState> _votingDataBlocSubscription;
  final String _voteRef;

  VotingResultsBloc({
    required VotingDataBloc votingDataBloc,
    required String voteRef,
  })  : _voteRef = voteRef,
        super(VotingResultsState(
          votes: votingDataBloc.state.data,
        )) {
    _votingDataBlocSubscription = votingDataBloc.stream.listen(
      (VotingDataState state) {
        add(
          UpdateVotingData(
            votingData: state.data,
          ),
        );
      },
    );
    // Event listeners
    on<UpdateVotingData>(_updateVotingData);
    on<UpdateVotingResults>(_updateVotingResults);
    on<ChangeSort>(_changeSort);
    // Init
    add(const UpdateVotingResults());
  }

  @override
  Future<void> close() {
    _votingDataBlocSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _updateVotingData(
    UpdateVotingData event,
    Emitter<VotingResultsState> emit,
  ) {
    emit(
      state.copyWith(
        votes: event.votingData[_voteRef],
      ),
    );
  }

  FutureOr<void> _updateVotingResults(
    UpdateVotingResults event,
    Emitter<VotingResultsState> emit,
  ) {
    final Map<String, dynamic> voteData = state.votes[_voteRef];
    final List<VotingResult> votingResults = voteData.entries.map((e) {
      final Map<String, bool?> userVotes =
          Map<String, bool?>.from(e.value as Map);
      final int upVotes =
          userVotes.values.where((bool? vote) => vote == true).length;
      final int downVotes =
          userVotes.values.where((bool? vote) => vote == false).length;
      return VotingResult(
        record: e.key,
        upVotes: upVotes,
        downVotes: downVotes,
        scoreVotes: upVotes - downVotes,
      );
    }).toList();
    switch (state.sort) {
      case CosplayVotingResultsSort.score:
        votingResults.sort(
          (VotingResult a, VotingResult b) =>
              b.scoreVotes.compareTo(a.scoreVotes),
        );
        break;
      case CosplayVotingResultsSort.upVote:
        votingResults.sort(
          (VotingResult a, VotingResult b) => b.upVotes.compareTo(a.upVotes),
        );
        break;
      case CosplayVotingResultsSort.downVote:
        votingResults.sort(
          (VotingResult a, VotingResult b) =>
              b.downVotes.compareTo(a.downVotes),
        );
        break;
    }
    emit(state.copyWith(votingResults: votingResults));
  }

  FutureOr<void> _changeSort(
    ChangeSort event,
    Emitter<VotingResultsState> emit,
  ) {
    emit(state.copyWith(
      sort: event.sort,
    ));
    add(const UpdateVotingResults());
  }
}
