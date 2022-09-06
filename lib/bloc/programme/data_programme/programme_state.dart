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
  final Map<String, ProgrammeEntry> entries;

  const ProgrammeState({
    required this.status,
    this.message = '',
    required this.programme,
    required this.entries,
  });

  Map<String, ProgPlace> get programmePlaces => programme.places;
  List<ProgNotification> get programmeNotifications => programme.notifications;

  List<ProgrammeEntry> get programmeEntries => entries.values.toList();

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
    Map<String, ProgrammeEntry>? entries,
  }) {
    return ProgrammeState(
      status: status ?? this.status,
      message: message ?? this.message,
      programme: programme ?? this.programme,
      entries: entries ?? this.entries,
    );
  }
}
