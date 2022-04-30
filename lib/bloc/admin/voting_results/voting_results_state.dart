part of 'voting_results_bloc.dart';

class VotingResult extends Equatable {
  final String record;
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

class VotingResultsState extends Equatable {
  final Map<String, dynamic> votes;
  final List<VotingResult> votingResults;
  final CosplayVotingResultsSort sort;
  const VotingResultsState({
    required this.votes,
    this.votingResults = const [],
    this.sort = CosplayVotingResultsSort.score,
  });

  @override
  List<Object> get props => [
        votes,
        votingResults,
        sort,
      ];

  VotingResultsState copyWith({
    Map<String, Map<String, bool?>>? votes,
    List<CosplayRecord>? records,
    List<VotingResult>? votingResults,
    CosplayVotingResultsSort? sort,
  }) {
    return VotingResultsState(
      votes: votes ?? this.votes,
      votingResults: votingResults ?? this.votingResults,
      sort: sort ?? this.sort,
    );
  }
}
