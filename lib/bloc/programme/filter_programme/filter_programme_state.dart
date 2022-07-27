part of 'filter_programme_bloc.dart';

class FilterProgrammeState extends Equatable {
  // Bloc data
  final List<ProgEntry> programmeEntries;
  final Set<String> myProgrammeEntryIds;
  // Control
  final bool searchActive;
  //Filtered entry list
  final List<ProgEntry> programmeEntriesFiltered;
  // Programme filter options
  final Set<DateTime> availableDates;
  final Set<ProgEntryType> availableEntryTypes;
  final Set<String?> availableEntryPlaces;
  // Filters
  final bool onlyMyProgramme;
  final Set<DateTime> dateFilter;
  final Set<ProgEntryType> entryTypeFilter;
  final Set<String> entryPlacesFilter;
  final String queryString;

  const FilterProgrammeState({
    this.programmeEntries = const <ProgEntry>[],
    this.programmeEntriesFiltered = const <ProgEntry>[],
    this.searchActive = false,
    this.availableDates = const <DateTime>{},
    this.availableEntryTypes = const <ProgEntryType>{},
    this.availableEntryPlaces = const <String>{},
    this.myProgrammeEntryIds = const <String>{},
    this.onlyMyProgramme = false,
    this.dateFilter = const <DateTime>{},
    this.entryTypeFilter = const <ProgEntryType>{},
    this.entryPlacesFilter = const <String>{},
    this.queryString = '',
  });

  @override
  List<Object> get props => [
        programmeEntries,
        programmeEntriesFiltered,
        searchActive,
        myProgrammeEntryIds,
        availableDates,
        availableEntryTypes,
        availableEntryPlaces,
        onlyMyProgramme,
        dateFilter,
        entryTypeFilter,
        entryPlacesFilter,
        queryString,
      ];

  FilterProgrammeState copyWith({
    List<ProgEntry>? programmeEntries,
    Set<String>? myProgrammeEntryIds,
    bool? searchActive,
    List<ProgEntry>? programmeEntriesFiltered,
    Set<DateTime>? availableDates,
    Set<ProgEntryType>? availableEntryTypes,
    Set<String?>? availableEntryPlaces,
    bool? onlyMyProgramme,
    Set<DateTime>? dateFilter,
    Set<ProgEntryType>? entryTypeFilter,
    Set<String>? entryPlacesFilter,
    String? queryString,
  }) {
    return FilterProgrammeState(
      programmeEntries: programmeEntries ?? this.programmeEntries,
      myProgrammeEntryIds: myProgrammeEntryIds ?? this.myProgrammeEntryIds,
      searchActive: searchActive ?? this.searchActive,
      programmeEntriesFiltered:
          programmeEntriesFiltered ?? this.programmeEntriesFiltered,
      availableDates: availableDates ?? this.availableDates,
      availableEntryTypes: availableEntryTypes ?? this.availableEntryTypes,
      availableEntryPlaces: availableEntryPlaces ?? this.availableEntryPlaces,
      onlyMyProgramme: onlyMyProgramme ?? this.onlyMyProgramme,
      dateFilter: dateFilter ?? this.dateFilter,
      entryTypeFilter: entryTypeFilter ?? this.entryTypeFilter,
      entryPlacesFilter: entryPlacesFilter ?? this.entryPlacesFilter,
      queryString: queryString ?? this.queryString,
    );
  }
}
