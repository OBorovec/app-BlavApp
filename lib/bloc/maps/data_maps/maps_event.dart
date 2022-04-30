part of 'maps_bloc.dart';

abstract class MapsEvent extends Equatable {
  const MapsEvent();

  @override
  List<Object> get props => [];
}

class MapsStreamChanged extends MapsEvent {
  final Maps maps;

  const MapsStreamChanged({
    required this.maps,
  });
}

class MapsSubscriptionFailed extends MapsEvent {
  final String message;

  const MapsSubscriptionFailed({required this.message});
}
