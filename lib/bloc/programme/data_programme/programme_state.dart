part of 'programme_bloc.dart';

enum ProgrammeStatus {
  initial,
  loaded,
  error,
}

class ProgrammeState extends Equatable {
  final ProgrammeStatus status;
  final String message;
  final List<ProgEntry> programmeEntries;

  const ProgrammeState({
    required this.status,
    this.message = '',
    this.programmeEntries = const <ProgEntry>[],
  });

  @override
  List<Object> get props => [
        status,
        message,
        programmeEntries,
      ];

  ProgrammeState copyWith({
    ProgrammeStatus? status,
    String? message,
    List<ProgEntry>? programmeEntries,
  }) {
    return ProgrammeState(
      status: status ?? this.status,
      message: message ?? this.message,
      programmeEntries: programmeEntries ?? this.programmeEntries,
    );
  }
}
