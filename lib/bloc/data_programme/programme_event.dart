part of 'programme_bloc.dart';

abstract class ProgrammeEvent extends Equatable {
  const ProgrammeEvent();

  @override
  List<Object> get props => [];
}

class ProgrammeSubscriptionFailed extends ProgrammeEvent {
  final String message;

  const ProgrammeSubscriptionFailed(this.message);
}

class ProgrammeStreamChanged extends ProgrammeEvent {
  final List<ProgEntry> programmeEntries;

  const ProgrammeStreamChanged({
    required this.programmeEntries,
  });
}

class UpdateMyProgrammeList extends ProgrammeEvent {
  final Set<String> programmeEntryIds;

  const UpdateMyProgrammeList({
    required this.programmeEntryIds,
  });
}

class ApplyProgrammeFilters extends ProgrammeEvent {
  const ApplyProgrammeFilters();
}

class ResetProgrammeFilters extends ProgrammeEvent {
  const ResetProgrammeFilters();
}

class UseMyProgrammeFilter extends ProgrammeEvent {
  final bool value;

  const UseMyProgrammeFilter(
    this.value,
  );
}

class ProgrammeDateFilter extends ProgrammeEvent {
  final DateTime date;

  const ProgrammeDateFilter(this.date);
}

class ProgrammeTypeFilter extends ProgrammeEvent {
  final ProgEntryType type;

  const ProgrammeTypeFilter(this.type);
}

class ProgrammePlaceFilter extends ProgrammeEvent {
  final String placeID;

  const ProgrammePlaceFilter(this.placeID);
}

class ProgrammeTextFilter extends ProgrammeEvent {
  final String text;

  const ProgrammeTextFilter(this.text);
}
