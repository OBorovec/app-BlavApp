part of 'programme_bloc.dart';

abstract class ProgrammeState extends Equatable {
  const ProgrammeState();

  @override
  List<Object> get props => [];
}

class ProgrammeInitial extends ProgrammeState {
  const ProgrammeInitial();
}

class ProgrammeFailState extends ProgrammeState {
  final String message;

  const ProgrammeFailState(this.message);
}

class ProgrammeLoaded extends ProgrammeState {
  final List<ProgEntry> programmeEntries;
  final List<ProgEntry> programmeEntriesFiltered;
  final Set<String> myProgrammeEntryIds;
  // Programme filter options
  final Set<DateTime> availableDates;
  final Set<ProgEntryType> availableEntryTypes;
  final Set<String?> availableEntryPlaces;
  // filters
  final bool showOnlyMyProgramme;
  final Set<DateTime> dateFilter;
  final Set<ProgEntryType> entryTypeFilter;
  final Set<String> entryPlacesFilter;
  final String queryString;

  const ProgrammeLoaded({
    required this.programmeEntries,
    required this.programmeEntriesFiltered,
    this.myProgrammeEntryIds = const <String>{},
    this.availableDates = const <DateTime>{},
    this.availableEntryTypes = const <ProgEntryType>{},
    this.availableEntryPlaces = const <String>{},
    this.showOnlyMyProgramme = false,
    this.dateFilter = const <DateTime>{},
    this.entryTypeFilter = const <ProgEntryType>{},
    this.entryPlacesFilter = const <String>{},
    this.queryString = '',
  });

  @override
  List<Object> get props => [
        programmeEntries,
        programmeEntriesFiltered,
        showOnlyMyProgramme,
        dateFilter,
        entryTypeFilter,
        entryPlacesFilter,
        queryString,
      ];

  ProgrammeLoaded copyWith({
    List<ProgEntry>? programmeEntries,
    List<ProgEntry>? programmeEntriesFiltered,
    Set<DateTime>? availableDates,
    Set<ProgEntryType>? availableEntryTypes,
    Set<String?>? availableEntryPlaces,
    bool? showOnlyMyProgramme,
    Set<DateTime>? dateFilter,
    Set<ProgEntryType>? entryTypeFilter,
    Set<String>? entryPlacesFilter,
    String? queryString,
  }) {
    return ProgrammeLoaded(
      programmeEntries: programmeEntries ?? this.programmeEntries,
      programmeEntriesFiltered:
          programmeEntriesFiltered ?? this.programmeEntriesFiltered,
      availableDates: availableDates ?? this.availableDates,
      availableEntryTypes: availableEntryTypes ?? this.availableEntryTypes,
      availableEntryPlaces: availableEntryPlaces ?? this.availableEntryPlaces,
      showOnlyMyProgramme: showOnlyMyProgramme ?? this.showOnlyMyProgramme,
      dateFilter: dateFilter ?? this.dateFilter,
      entryTypeFilter: entryTypeFilter ?? this.entryTypeFilter,
      entryPlacesFilter: entryPlacesFilter ?? this.entryPlacesFilter,
      queryString: queryString ?? this.queryString,
    );
  }
}
