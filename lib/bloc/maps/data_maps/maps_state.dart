part of 'maps_bloc.dart';

enum DataStatus {
  initial,
  loaded,
  failed,
}

class MapsState extends Equatable {
  final DataStatus status;
  final String message;
  final List<MapRecord> mapRecords;
  final List<RealWorldRecord> realWorldRecords;

  const MapsState({
    this.status = DataStatus.initial,
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
    DataStatus? status,
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
