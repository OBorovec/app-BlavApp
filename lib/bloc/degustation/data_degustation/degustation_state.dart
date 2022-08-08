part of 'degustation_bloc.dart';

enum DegustationStatus {
  initial,
  loaded,
  error,
}

class DegustationState extends Equatable {
  final DegustationStatus status;
  final String message;
  final Degustation degustation;

  const DegustationState({
    this.status = DegustationStatus.initial,
    this.message = '',
    this.degustation = const Degustation(),
  });

  List<DegusItem> get degustationItems => degustation.items;
  Map<String, DegusPlace> get degustationPlaces => degustation.places;
  List<DegusNotification> get degustationNotifications =>
      degustation.notifications;

  @override
  List<Object> get props => [
        status,
        message,
        degustation,
      ];

  DegustationState copyWith({
    DegustationStatus? status,
    String? message,
    Degustation? degustation,
  }) {
    return DegustationState(
      status: status ?? this.status,
      message: message ?? this.message,
      degustation: degustation ?? this.degustation,
    );
  }
}
