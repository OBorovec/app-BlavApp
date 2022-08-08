part of 'cosplay_voting_results_bloc.dart';

abstract class CosplayVotingResultsEvent extends Equatable {
  const CosplayVotingResultsEvent();

  @override
  List<Object> get props => [];
}

class VoteDocumentStreamChanged extends CosplayVotingResultsEvent {
  final Map<String, Map<String, bool?>> votes;

  const VoteDocumentStreamChanged({
    required this.votes,
  });
}

class VoteDocumentStreamFailed extends CosplayVotingResultsEvent {
  final String message;

  const VoteDocumentStreamFailed({required this.message});
}

class CosplayStreamChanged extends CosplayVotingResultsEvent {
  final List<CosplayRecord> records;

  const CosplayStreamChanged({
    required this.records,
  });
}

class CosplayStreamFailed extends CosplayVotingResultsEvent {
  final String message;

  const CosplayStreamFailed({required this.message});
}

class UpdateVotingResults extends CosplayVotingResultsEvent {
  const UpdateVotingResults();
}

class ChangeSort extends CosplayVotingResultsEvent {
  final CosplayVotingResultsSort sort;
  const ChangeSort({required this.sort});
}
