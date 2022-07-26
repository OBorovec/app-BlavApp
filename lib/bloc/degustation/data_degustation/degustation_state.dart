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

  Map<String, DegusItem> get degustations => degustation.items;
  Map<String, DegusPlace> get degustationPlaces => degustation.places;
  List<DegusNotification> get degustationNotifications =>
      degustation.notifications;

  List<DegusItem> get degustationItems => degustations.values.toList();

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
