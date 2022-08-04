part of 'degustation_bloc.dart';

enum DegustationStatus {
  initial,
  loaded,
  error,
}

class DegustationState extends Equatable {
  final DegustationStatus status;
  final String message;
  final List<DegusItem> degustationItems;
  final Map<String, DegusPlace> degustationPlaces;
  final List<DegusNotification> notifications;

  const DegustationState({
    this.status = DegustationStatus.initial,
    this.message = '',
    this.degustationItems = const <DegusItem>[],
    this.degustationPlaces = const {},
    this.notifications = const [],
  });

  @override
  List<Object> get props => [
        status,
        message,
        degustationItems,
        degustationPlaces,
        notifications,
      ];

  DegustationState copyWith({
    DegustationStatus? status,
    String? message,
    List<DegusItem>? degustationItems,
    Map<String, DegusPlace>? degustationPlaces,
    List<DegusNotification>? notifications,
  }) {
    return DegustationState(
      status: status ?? this.status,
      message: message ?? this.message,
      degustationItems: degustationItems ?? this.degustationItems,
      degustationPlaces: degustationPlaces ?? this.degustationPlaces,
      notifications: notifications ?? this.notifications,
    );
  }
}
