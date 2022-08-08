part of 'cosplay_voting_results_bloc.dart';

enum CosplayVotingResultsStatus {
  initial,
  ready,
  error,
}

class VotingResult extends Equatable {
  final CosplayRecord record;
  final int upVotes;
  final int downVotes;
  final int scoreVotes;

  const VotingResult({
    required this.record,
    required this.upVotes,
    required this.downVotes,
    required this.scoreVotes,
  });

  @override
  List<Object?> get props => [record, upVotes, downVotes, scoreVotes];
}

enum CosplayVotingResultsSort {
  upVote,
  downVote,
  score,
}

class CosplayVotingResultsState extends Equatable {
  final CosplayVotingResultsStatus status;
  final String message;
  final CosplayVotingResultsStatus statusCosplay;
  final CosplayVotingResultsStatus statusVoting;
  final Map<String, Map<String, bool?>> votes;
  final List<CosplayRecord> records;
  final List<VotingResult> votingResults;
  final CosplayVotingResultsSort sort;
  const CosplayVotingResultsState({
    this.status = CosplayVotingResultsStatus.initial,
    this.statusCosplay = CosplayVotingResultsStatus.initial,
    this.statusVoting = CosplayVotingResultsStatus.initial,
    this.message = '',
    this.votes = const {},
    this.records = const [],
    this.votingResults = const [],
    this.sort = CosplayVotingResultsSort.score,
  });

  @override
  List<Object> get props => [
        status,
        statusCosplay,
        statusVoting,
        message,
        votes,
        records,
        votingResults,
        sort,
      ];

  CosplayVotingResultsState copyWith({
    CosplayVotingResultsStatus? status,
    String? message,
    CosplayVotingResultsStatus? statusCosplay,
    CosplayVotingResultsStatus? statusVoting,
    Map<String, Map<String, bool?>>? votes,
    List<CosplayRecord>? records,
    List<VotingResult>? votingResults,
    CosplayVotingResultsSort? sort,
  }) {
    return CosplayVotingResultsState(
      status: status ?? this.status,
      message: message ?? this.message,
      statusCosplay: statusCosplay ?? this.statusCosplay,
      statusVoting: statusVoting ?? this.statusVoting,
      votes: votes ?? this.votes,
      records: records ?? this.records,
      votingResults: votingResults ?? this.votingResults,
      sort: sort ?? this.sort,
    );
  }
}
