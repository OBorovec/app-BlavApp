part of 'maps_bloc.dart';

enum MapsStatus {
  initial,
  loaded,
  error,
}

class MapsState extends Equatable {
  final MapsStatus status;
  final String message;
  final List<MapRecord> mapRecords;
  final List<RealWorldRecord> realWorldRecords;

  const MapsState({
    this.status = MapsStatus.initial,
    this.message = '',
    this.mapRecords = const [],
    this.realWorldRecords = const [],
  });

  @override
  List<Object> get props => [
        status,
        message,
        mapRecords,
        realWorldRecords,
      ];

  MapsState copyWith({
    MapsStatus? status,
    String? message,
    List<MapRecord>? mapRecords,
    List<RealWorldRecord>? realWorldRecords,
  }) {
    return MapsState(
      status: status ?? this.status,
      message: message ?? this.message,
      mapRecords: mapRecords ?? this.mapRecords,
      realWorldRecords: realWorldRecords ?? this.realWorldRecords,
    );
  }
}
