part of 'degustation_bloc.dart';

abstract class DegustationEvent extends Equatable {
  const DegustationEvent();

  @override
  List<Object> get props => [];
}

class DegustationStreamChanged extends DegustationEvent {
  final Degustation degustation;

  const DegustationStreamChanged({
    required this.degustation,
  });
}

class DegustationSubscriptionFailed extends DegustationEvent {
  final String message;

  const DegustationSubscriptionFailed({required this.message});
}
