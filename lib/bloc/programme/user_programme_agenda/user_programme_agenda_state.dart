part of 'user_programme_agenda_bloc.dart';

class UserProgrammeAgendaState extends Equatable {
  // Bloc data
  final List<ProgEntry> programmeEntries;
  final Set<String> myProgrammeEntryIds;
  final Event event;
  // View
  final List<ProgEntry> agendaData;

  const UserProgrammeAgendaState({
    this.programmeEntries = const <ProgEntry>[],
    this.myProgrammeEntryIds = const <String>{},
    this.agendaData = const <ProgEntry>[],
    required this.event,
  });

  @override
  List<Object> get props => [
        programmeEntries,
        myProgrammeEntryIds,
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
