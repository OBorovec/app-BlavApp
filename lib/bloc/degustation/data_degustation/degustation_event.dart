part of 'degustation_bloc.dart';

abstract class DegustationEvent extends Equatable {
  const DegustationEvent();

  @override
  List<Object> get props => [];
}

class DegustationStreamChanged extends DegustationEvent {
  final List<DegusItem> degustationItems;
  final Map<String, DegusPlace> degustationPlaces;
  final List<DegusNotification> degustationNotifications;

  const DegustationStreamChanged({
    required this.degustationItems,
    required this.degustationPlaces,
    required this.degustationNotifications,
  });
}

class DegustationSubscriptionFailed extends DegustationEvent {
  final String message;

  const DegustationSubscriptionFailed(this.message);
}
