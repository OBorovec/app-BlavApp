part of 'highlight_programme_bloc.dart';

class HighlightProgrammeState extends Equatable {
  // Bloc data
  final List<ProgEntry> programmeEntries;
  final Set<String> myProgrammeEntryIds;
  // View Data
  final List<ProgNotification> notifications;
  final List<ProgEntry> ongoingEntries;
  final List<ProgEntry> upcomingEntries;
  final List<ProgEntry> upcomingMyEntries;

  const HighlightProgrammeState({
    this.programmeEntries = const <ProgEntry>[],
    this.myProgrammeEntryIds = const <String>{},
    this.notifications = const <ProgNotification>[],
    this.ongoingEntries = const <ProgEntry>[],
    this.upcomingEntries = const <ProgEntry>[],
    this.upcomingMyEntries = const <ProgEntry>[],
  });

  @override
  List<Object> get props => [
        programmeEntries,
        myProgrammeEntryIds,
        upcomingEntries,
        upcomingMyEntries,
      ];

  HighlightProgrammeState copyWith({
    List<ProgEntry>? programmeEntries,
    Set<String>? myProgrammeEntryIds,
    List<ProgEntry>? ongoingEntries,
    List<ProgEntry>? upcomingEntries,
    List<ProgEntry>? upcomingMyEntries,
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
