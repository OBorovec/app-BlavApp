part of 'voting_results_bloc.dart';

abstract class VotingResultsEvent extends Equatable {
  const VotingResultsEvent();

  @override
  List<Object> get props => [];
}

class UpdateVotingData extends VotingResultsEvent {
  final Map<String, dynamic> votingData;

  const UpdateVotingData({
    required this.votingData,
  });
}

class UpdateVotingResults extends VotingResultsEvent {
  const UpdateVotingResults();
}

class ChangeSort extends VotingResultsEvent {
  final CosplayVotingResultsSort sort;
  const ChangeSort({required this.sort});
}
