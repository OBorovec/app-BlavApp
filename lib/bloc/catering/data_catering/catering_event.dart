part of 'catering_bloc.dart';

abstract class CateringEvent extends Equatable {
  const CateringEvent();

  @override
  List<Object> get props => [];
}

class CateringStreamChanged extends CateringEvent {
  final List<CaterItem> cateringItems;
  final Map<String, CaterPlace> cateringPlaces;
  final List<CaterNotification> cateringNotifications;

  const CateringStreamChanged({
    required this.cateringItems,
    required this.cateringPlaces,
    required this.cateringNotifications,
  });
}

class CateringSubscriptionFailed extends CateringEvent {
  final String message;

  const CateringSubscriptionFailed({required this.message});
}
