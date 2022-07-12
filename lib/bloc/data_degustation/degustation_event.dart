part of 'degustation_bloc.dart';

abstract class DegustationEvent extends Equatable {
  const DegustationEvent();

  @override
  List<Object> get props => [];
}

class DegustationSubscriptionFailed extends DegustationEvent {
  final String message;

  const DegustationSubscriptionFailed(this.message);
}

class DegustationStreamChanged extends DegustationEvent {
  final List<DegusItem> degustationItems;

  const DegustationStreamChanged({
    required this.degustationItems,
  });
}
