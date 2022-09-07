part of 'user_programme_agenda_bloc.dart';

class AgendaData {
  ProgrammeEntry entry;
  bool colored;

  AgendaData({
    required this.entry,
    required this.colored,
  });
}

class UserProgrammeAgendaState extends Equatable {
  // Bloc data
  final List<ProgrammeEntry> programmeEntries;
  final Set<String> myProgrammeEntryIds;
  final Event event;
  //State data
  final bool singleDayMod;
  final DateTime? singleDay;
  final bool showAll;
  // View
  final DateTime? maxDate;
  final DateTime? minDate;
  final double minHour;
  final double maxHour;
  final int? dayCount;
  final List<int>? nonEventDays;
  final List<AgendaData> agendaData;

  const UserProgrammeAgendaState({
    this.programmeEntries = const <ProgrammeEntry>[],
    this.myProgrammeEntryIds = const <String>{},
    required this.event,
    this.singleDayMod = false,
    this.singleDay,
    this.showAll = false,
    this.maxDate,
    this.minDate,
    this.minHour = 8,
    this.maxHour = 24,
    this.dayCount,
    this.nonEventDays,
    this.agendaData = const [],
  });

  @override
  List<Object> get props => [
        programmeEntries,
        myProgrammeEntryIds,
        event,
        singleDayMod,
        singleDay ?? '',
        showAll,
        maxDate ?? '',
        minDate ?? '',
        minHour,
        maxHour,
        dayCount ?? '',
        nonEventDays ?? '',
        agendaData,
      ];

  UserProgrammeAgendaState copyWith({
    List<ProgrammeEntry>? programmeEntries,
    Set<String>? myProgrammeEntryIds,
    Event? event,
    bool? singleDayMod,
    DateTime? singleDay,
    bool? showAll,
    DateTime? maxDate,
    DateTime? minDate,
    double? minHour,
    double? maxHour,
    int? dayCount,
    List<int>? nonEventDays,
    List<AgendaData>? agendaData,
  }) {
    return UserProgrammeAgendaState(
      programmeEntries: programmeEntries ?? this.programmeEntries,
      myProgrammeEntryIds: myProgrammeEntryIds ?? this.myProgrammeEntryIds,
      event: event ?? this.event,
      singleDayMod: singleDayMod ?? this.singleDayMod,
      singleDay: singleDay ?? this.singleDay,
      showAll: showAll ?? this.showAll,
      maxDate: maxDate ?? this.maxDate,
      minDate: minDate ?? this.minDate,
      minHour: minHour ?? this.minHour,
      maxHour: maxHour ?? this.maxHour,
      dayCount: dayCount ?? this.dayCount,
      nonEventDays: nonEventDays ?? this.nonEventDays,
      agendaData: agendaData ?? this.agendaData,
    );
  }

  @override
  String toString() {
    return 'UserProgrammeAgendaState(programmeEntries: ${programmeEntries.length}, myProgrammeEntryIds: ${myProgrammeEntryIds.length}, event: ${event.id}, singleDay: $singleDay, maxDate: $maxDate, minDate: $minDate, minHour: $minHour, maxHour: $maxHour,dayCount: $dayCount, nonEventDays: $nonEventDays, agendaData: $agendaData)';
  }
}
