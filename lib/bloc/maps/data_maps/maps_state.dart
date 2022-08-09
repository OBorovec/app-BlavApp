part of 'maps_bloc.dart';

enum MapsStatus {
  initial,
  loaded,
  error,
}

class MapsState extends Equatable {
  final MapsStatus status;
  final String message;
  final Maps maps;

  const MapsState({
    this.status = MapsStatus.initial,
    this.message = '',
    this.maps = const Maps(),
  });

  Map<String, MapRecord> get mapRecords => maps.mapRecords;
  List<RealWorldRecord> get realWorldRecords => maps.realWorldRecords;

  @override
  List<Object> get props => [
        status,
        message,
        maps,
      ];

  MapsState copyWith({
    MapsStatus? status,
    String? message,
    Maps? maps,
  }) {
    return MapsState(
      status: status ?? this.status,
      message: message ?? this.message,
      maps: maps ?? this.maps,
    );
  }
}
