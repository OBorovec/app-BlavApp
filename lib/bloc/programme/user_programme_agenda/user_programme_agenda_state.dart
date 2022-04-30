part of 'user_programme_agenda_bloc.dart';

class UserProgrammeAgendaState extends Equatable {
  // Bloc data
  final List<ProgEntry> programmeEntries;
  final Set<String> myProgrammeEntryIds;
  final Event event;
  // View
  final DateTime maxDate;
  final DateTime minDate;
  final int dayCount;
  final List<int> nonEventDays;
  final List<ProgEntry> agendaData;

  UserProgrammeAgendaState({
    this.programmeEntries = const <ProgEntry>[],
    this.myProgrammeEntryIds = const <String>{},
    required this.event,
    this.agendaData = const <ProgEntry>[],
  })  : maxDate = event.dayEnd,
        minDate = event.dayStart,
        dayCount = event.dayEnd.difference(event.dayStart).inDays + 1,
        nonEventDays = List<int>.generate(7, (i) => i)
            .toSet()
            .difference(List<int>.generate(
              event.dayEnd.difference(event.dayStart).inDays + 1,
              (i) => (event.dayStart.weekday + i) % 7,
            ).toSet())
            .toList();

  // Explonation of the above:
  // final DateTime maxDate = state.event.dayEnd;
  // final DateTime minDate = state.event.dayStart;
  // final Set<int> allDays = List<int>.generate(7, (i) => i).toSet();
  // final int dayCount = maxDate.difference(minDate).inDays + 1;
  // final Set<int> eventDays = List<int>.generate(
  //   dayCount,
  //   (i) => (minDate.weekday + i) % 7,
  // ).toSet();
  // final List<int> nonEventDays = allDays.difference(eventDays).toList();

  @override
  List<Object> get props => [
        programmeEntries,
        myProgrammeEntryIds,
        event,
        agendaData,
      ];

  UserProgrammeAgendaState copyWith({
    List<ProgEntry>? programmeEntries,
    Set<String>? myProgrammeEntryIds,
    Event? event,
    List<ProgEntry>? agendaData,
  }) {
    return UserProgrammeAgendaState(
      programmeEntries: programmeEntries ?? this.programmeEntries,
      myProgrammeEntryIds: myProgrammeEntryIds ?? this.myProgrammeEntryIds,
      event: event ?? this.event,
      agendaData: agendaData ?? this.agendaData,
    );
  }
}
