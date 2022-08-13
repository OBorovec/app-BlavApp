part of 'voting_data_bloc.dart';

enum DataStatus {
  initial,
  loaded,
  error,
}

class VotingDataState extends Equatable {
  final DataStatus status;
  final String message;
  final Map<String, dynamic> data;

  const VotingDataState({
    this.status = DataStatus.initial,
    this.message = '',
    this.data = const {},
  });

  @override
  List<Object> get props => [
        status,
        message,
        data,
      ];

  VotingDataState copyWith({
    DataStatus? status,
    String? message,
    Map<String, Map<String, Map<String, String>>>? data,
  }) {
    return VotingDataState(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}
