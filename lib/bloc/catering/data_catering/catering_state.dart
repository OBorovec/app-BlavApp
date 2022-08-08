part of 'catering_bloc.dart';

enum CateringStatus {
  initial,
  loaded,
  error,
}

class CateringState extends Equatable {
  final CateringStatus status;
  final String message;
  final Catering catering;

  const CateringState({
    this.status = CateringStatus.initial,
    this.message = '',
    this.catering = const Catering(),
  });

  List<CaterItem> get cateringItems => catering.items;
  Map<String, CaterPlace> get cateringPlaces => catering.places;
  List<CaterNotification> get cateringNotifications => catering.notifications;

  @override
  List<Object> get props => [
        status,
        message,
      ];

  CateringState copyWith({
    CateringStatus? status,
    String? message,
    Catering? catering,
  }) {
    return CateringState(
      status: status ?? this.status,
      message: message ?? this.message,
      catering: catering ?? this.catering,
    );
  }
}
