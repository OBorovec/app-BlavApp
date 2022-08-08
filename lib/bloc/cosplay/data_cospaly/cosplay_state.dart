part of 'cosplay_bloc.dart';

enum CosplayStatus {
  initial,
  loaded,
  error,
}

class CosplayState extends Equatable {
  final CosplayStatus status;
  final String message;
  final Cosplay cosplay;

  const CosplayState({
    this.status = CosplayStatus.initial,
    this.message = '',
    this.cosplay = const Cosplay(),
  });

  List<CosplayRecord> get cosplayRecords => cosplay.cosplayRecords;

  @override
  List<Object> get props => [status, cosplay];

  CosplayState copyWith({
    CosplayStatus? status,
    String? message,
    Cosplay? cosplay,
  }) {
    return CosplayState(
      status: status ?? this.status,
      message: message ?? this.message,
      cosplay: cosplay ?? this.cosplay,
    );
  }
}
