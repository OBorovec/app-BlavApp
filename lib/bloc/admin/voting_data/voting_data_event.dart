part of 'voting_data_bloc.dart';

abstract class VotingDataEvent extends Equatable {
  const VotingDataEvent();

  @override
  List<Object> get props => [];
}

class VotingStreamChanged extends VotingDataEvent {
  final Map<String, dynamic> votingData;

  const VotingStreamChanged({
    required this.votingData,
  });
}

class VotingSubscriptionFailed extends VotingDataEvent {
  final String message;

  const VotingSubscriptionFailed({required this.message});
}
