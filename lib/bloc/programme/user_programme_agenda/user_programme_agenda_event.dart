part of 'user_programme_agenda_bloc.dart';

abstract class UserProgrammeAgendaEvent extends Equatable {
  const UserProgrammeAgendaEvent();

  @override
  List<Object> get props => [];
}

class UpdateProgrammeEntries extends UserProgrammeAgendaEvent {
  final List<ProgrammeEntry> programmeEntries;

  const UpdateProgrammeEntries({
    required this.programmeEntries,
  });
}

class UpdateMyProgrammeEntryIds extends UserProgrammeAgendaEvent {
  final Set<String> myProgrammeEntryIds;

  const UpdateMyProgrammeEntryIds({
    required this.myProgrammeEntryIds,
  });
}

class UserAgendaScopeDate extends UserProgrammeAgendaEvent {
  final DateTime date;

  const UserAgendaScopeDate(this.date);
}

class UserAgendaResetView extends UserProgrammeAgendaEvent {
  const UserAgendaResetView();
}

class UserAgendaShowAllToggle extends UserProgrammeAgendaEvent {
  const UserAgendaShowAllToggle();
}
