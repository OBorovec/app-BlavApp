part of 'cosplay_bloc.dart';

enum CosplayStatus {
  initial,
  loaded,
  error,
}

class CosplayState extends Equatable {
  final CosplayStatus status;
  final String message;
  final List<CosplayRecord> cosplayRecords;

  const CosplayState({
    this.status = CosplayStatus.initial,
    this.message = '',
    this.cosplayRecords = const [],
  });

  @override
  List<Object> get props => [status, cosplayRecords];

  CosplayState copyWith({
    CosplayStatus? status,
    String? message,
    List<CosplayRecord>? cosplayRecords,
  }) {
    return CosplayState(
      status: status ?? this.status,
      message: message ?? this.message,
      cosplayRecords: cosplayRecords ?? this.cosplayRecords,
    );
  }
}
