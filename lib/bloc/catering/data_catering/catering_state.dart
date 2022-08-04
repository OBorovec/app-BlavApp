part of 'catering_bloc.dart';

enum CateringStatus {
  initial,
  loaded,
  error,
}

class CateringState extends Equatable {
  final CateringStatus status;
  final String message;
  final List<CaterItem> cateringItems;
  final Map<String, CaterPlace> cateringPlaces;
  final List<CaterNotification> notifications;

  const CateringState({
    this.status = CateringStatus.initial,
    this.message = '',
    this.cateringItems = const [],
    this.cateringPlaces = const {},
    this.notifications = const [],
  });

  @override
  List<Object> get props => [
        status,
        message,
        cateringItems,
        cateringPlaces,
        notifications,
      ];

  CateringState copyWith({
    CateringStatus? status,
    String? message,
    List<CaterItem>? cateringItems,
    Map<String, CaterPlace>? cateringPlaces,
    List<CaterNotification>? notifications,
  }) {
    return CateringState(
      status: status ?? this.status,
      message: message ?? this.message,
      cateringItems: cateringItems ?? this.cateringItems,
      cateringPlaces: cateringPlaces ?? this.cateringPlaces,
      notifications: notifications ?? this.notifications,
    );
  }
}
