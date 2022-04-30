part of 'highlight_programme_bloc.dart';

abstract class HighlightProgrammeEvent extends Equatable {
  const HighlightProgrammeEvent();

  @override
  List<Object> get props => [];
}

class UpdateProgrammeEntries extends HighlightProgrammeEvent {
  final List<ProgEntry> programmeEntries;

  const UpdateProgrammeEntries({
    required this.programmeEntries,
  });
}

class UpdateMyProgrammeEntryIds extends HighlightProgrammeEvent {
  final Set<String> myProgrammeEntryIds;

  const UpdateMyProgrammeEntryIds({
    required this.myProgrammeEntryIds,
  });
}

class UpdateViewData extends HighlightProgrammeEvent {
  const UpdateViewData();
}
