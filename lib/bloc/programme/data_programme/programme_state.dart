part of 'programme_bloc.dart';

enum ProgrammeStatus {
  initial,
  loaded,
  error,
}

class ProgrammeState extends Equatable {
  final ProgrammeStatus status;
  final String message;
  final Programme programme;

  const ProgrammeState({
    required this.status,
    this.message = '',
    required this.programme,
  });

  List<ProgEntry> get programmeEntries => programme.entries;
  Map<String, ProgPlace> get programmePlaces => programme.places;
  List<ProgNotification> get programmeNotifications => programme.notifications;

  @override
  List<Object> get props => [
        status,
        message,
        programme,
      ];

  ProgrammeState copyWith({
    ProgrammeStatus? status,
    String? message,
    Programme? programme,
  }) {
    return ProgrammeState(
      status: status ?? this.status,
      message: message ?? this.message,
      programme: programme ?? this.programme,
    );
  }
}
