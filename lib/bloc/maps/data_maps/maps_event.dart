part of 'maps_bloc.dart';

abstract class MapsEvent extends Equatable {
  const MapsEvent();

  @override
  List<Object> get props => [];
}

class MapsStreamChanged extends MapsEvent {
  final List<MapRecord> mapRecords;
  final List<RealWorldRecord> realWorldRecords;

  const MapsStreamChanged({
    required this.mapRecords,
    required this.realWorldRecords,
  });
}

class MapsSubscriptionFailed extends MapsEvent {
  final String message;

  const MapsSubscriptionFailed(this.message);
}
