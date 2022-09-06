part of 'highlight_programme_bloc.dart';

class HighlightProgrammeState extends Equatable {
  // Bloc data
  final List<ProgrammeEntry> programmeEntries;
  final Set<String> myProgrammeEntryIds;
  // View Data
  final List<ProgNotification> notifications;
  final List<ProgrammeEntry> ongoingEntries;
  final List<ProgrammeEntry> upcomingEntries;
  final List<ProgrammeEntry> upcomingMyEntries;

  const HighlightProgrammeState({
    this.programmeEntries = const <ProgrammeEntry>[],
    this.myProgrammeEntryIds = const <String>{},
    this.notifications = const <ProgNotification>[],
    this.ongoingEntries = const <ProgrammeEntry>[],
    this.upcomingEntries = const <ProgrammeEntry>[],
    this.upcomingMyEntries = const <ProgrammeEntry>[],
  });

  @override
  List<Object> get props => [
        programmeEntries,
        myProgrammeEntryIds,
        upcomingEntries,
        upcomingMyEntries,
      ];

  HighlightProgrammeState copyWith({
    List<ProgrammeEntry>? programmeEntries,
    Set<String>? myProgrammeEntryIds,
    List<ProgrammeEntry>? ongoingEntries,
    List<ProgrammeEntry>? upcomingEntries,
    List<ProgrammeEntry>? upcomingMyEntries,
  }) {
    return HighlightProgrammeState(
      programmeEntries: programmeEntries ?? this.programmeEntries,
      myProgrammeEntryIds: myProgrammeEntryIds ?? this.myProgrammeEntryIds,
      ongoingEntries: ongoingEntries ?? this.ongoingEntries,
      upcomingEntries: upcomingEntries ?? this.upcomingEntries,
      upcomingMyEntries: upcomingMyEntries ?? this.upcomingMyEntries,
    );
  }
}
