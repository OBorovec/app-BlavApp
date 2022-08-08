import 'dart:async';

import 'package:blavapp/bloc/cosplay/data_cospaly/cosplay_bloc.dart';
import 'package:blavapp/model/cosplay.dart';
import 'package:blavapp/model/support.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cosplay_voting_results_event.dart';
part 'cosplay_voting_results_state.dart';

class CosplayVotingResultsBloc
    extends Bloc<CosplayVotingResultsEvent, CosplayVotingResultsState> {
  final DataRepo _dataRepo;
  late final StreamSubscription<Cosplay> _cosplayStream;
  late final StreamSubscription<SupportVoting> _votingResultsStream;

  CosplayVotingResultsBloc({
    required DataRepo dataRepo,
    required CosplayBloc cosplayBloc,
    required String eventRef,
    required String voteRef,
  })  : _dataRepo = dataRepo,
        super(const CosplayVotingResultsState()) {
    _cosplayStream = _dataRepo.getCosplayStream(eventRef).listen(
          (Cosplay cosplay) => add(
            CosplayStreamChanged(
              records: cosplay.cosplayRecords,
            ),
          ),
        )..onError(
        (error) {
          if (error is NullDataException) {
            add(CosplayStreamFailed(message: error.message));
          } else {
            add(CosplayStreamFailed(message: error.toString()));
          }
        },
      );
    _votingResultsStream = _dataRepo.getCosplayVoteStream(voteRef).listen(
      (SupportVoting data) {
        if (data.votes != null) {
          add(
            VoteDocumentStreamChanged(
              votes: data.votes!,
            ),
          );
        } else {
          add(
            const VoteDocumentStreamChanged(
              votes: {},
            ),
          );
        }
      },
    )..onError(
        (error) {
          if (error is NullDataException) {
            add(CosplayStreamFailed(message: error.message));
          } else {
            add(CosplayStreamFailed(message: error.toString()));
          }
        },
      );
    // Event listeners
    on<VoteDocumentStreamChanged>(_onVoteDocumentStreamChanged);
    on<VoteDocumentStreamFailed>(_onVoteDocumentStreamFailed);
    on<CosplayStreamChanged>(_onCosplayStreamChanged);
    on<CosplayStreamFailed>(_onCosplayStreamFailed);
    on<UpdateVotingResults>(_updateVotingResults);
    on<ChangeSort>(_changeSort);
  }

  @override
  Future<void> close() {
    _cosplayStream.cancel();
    _votingResultsStream.cancel();
    return super.close();
  }

  FutureOr<void> _onVoteDocumentStreamChanged(
    VoteDocumentStreamChanged event,
    Emitter<CosplayVotingResultsState> emit,
  ) {
    emit(
      state.copyWith(
        statusVoting: CosplayVotingResultsStatus.ready,
        votes: event.votes,
      ),
    );
    add(const UpdateVotingResults());
  }

  FutureOr<void> _onVoteDocumentStreamFailed(
    VoteDocumentStreamFailed event,
    Emitter<CosplayVotingResultsState> emit,
  ) {
    emit(
      state.copyWith(
        status: CosplayVotingResultsStatus.error,
        message: event.message,
      ),
    );
  }

  FutureOr<void> _onCosplayStreamChanged(
    CosplayStreamChanged event,
    Emitter<CosplayVotingResultsState> emit,
  ) {
    emit(
      state.copyWith(
        statusCosplay: CosplayVotingResultsStatus.ready,
        records: event.records,
      ),
    );
    add(const UpdateVotingResults());
  }

  FutureOr<void> _onCosplayStreamFailed(
    CosplayStreamFailed event,
    Emitter<CosplayVotingResultsState> emit,
  ) {
    emit(
      state.copyWith(
        status: CosplayVotingResultsStatus.error,
        message: event.message,
      ),
    );
  }

  FutureOr<void> _updateVotingResults(
    UpdateVotingResults event,
    Emitter<CosplayVotingResultsState> emit,
  ) {
    if (state.statusVoting == CosplayVotingResultsStatus.ready &&
        state.statusCosplay == CosplayVotingResultsStatus.ready) {
      final List<VotingResult> votingResults = state.records.map(
        (CosplayRecord record) {
          if (state.votes.containsKey(record.id)) {
            final Map<String, bool?> votes = state.votes[record.id]!;
            final int upVotes =
                votes.values.where((bool? vote) => vote == true).length;
            final int downVotes =
                votes.values.where((bool? vote) => vote == false).length;
            return VotingResult(
              record: record,
              upVotes: upVotes,
              downVotes: downVotes,
              scoreVotes: upVotes - downVotes,
            );
          } else {
            return VotingResult(
              record: record,
              upVotes: 0,
              downVotes: 0,
              scoreVotes: 0,
            );
          }
        },
      ).toList();
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
      emit(
        state.copyWith(
          status: CosplayVotingResultsStatus.ready,
          votingResults: votingResults,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: CosplayVotingResultsStatus.initial,
        ),
      );
    }
  }

  FutureOr<void> _changeSort(
    ChangeSort event,
    Emitter<CosplayVotingResultsState> emit,
  ) {
    print('object');
    emit(state.copyWith(
      sort: event.sort,
    ));
    add(const UpdateVotingResults());
  }
}
