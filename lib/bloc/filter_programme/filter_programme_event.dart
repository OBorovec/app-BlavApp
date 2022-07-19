part of 'filter_programme_bloc.dart';

abstract class FilterProgrammeEvent extends Equatable {
  const FilterProgrammeEvent();

  @override
  List<Object> get props => [];
}

class UpdateProgrammeEntries extends FilterProgrammeEvent {
  final List<ProgEntry> programmeEntries;

  const UpdateProgrammeEntries({
    required this.programmeEntries,
  });
}

class UpdateMyProgrammeEntryIds extends FilterProgrammeEvent {
  final Set<String> myProgrammeEntryIds;

  const UpdateMyProgrammeEntryIds({
    required this.myProgrammeEntryIds,
  });
}

class SetAvailableFilters extends FilterProgrammeEvent {
  const SetAvailableFilters();
}

class ApplyProgrammeFilters extends FilterProgrammeEvent {
  const ApplyProgrammeFilters();
}

class ResetProgrammeFilters extends FilterProgrammeEvent {
  const ResetProgrammeFilters();
}

class UseMyProgrammeFilter extends FilterProgrammeEvent {
  final bool value;

  const UseMyProgrammeFilter(this.value);
}

class ProgrammeDateFilter extends FilterProgrammeEvent {
  final DateTime date;

  const ProgrammeDateFilter(this.date);
}

class ProgrammeTypeFilter extends FilterProgrammeEvent {
  final ProgEntryType type;

  const ProgrammeTypeFilter(this.type);
}

class ProgrammePlaceFilter extends FilterProgrammeEvent {
  final String placeID;

  const ProgrammePlaceFilter(this.placeID);
}

class ProgrammeTextFilter extends FilterProgrammeEvent {
  final String text;

  const ProgrammeTextFilter(this.text);
}
