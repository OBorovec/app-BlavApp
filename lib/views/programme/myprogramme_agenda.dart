import 'package:blavapp/bloc/data_programme/programme_bloc.dart';
import 'package:blavapp/bloc/filter_programme/filter_programme_bloc.dart';
import 'package:blavapp/bloc/localization/localization_bloc.dart';
import 'package:blavapp/model/prog_entry.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyProgrammeAgenda extends StatelessWidget {
  final DateTime minDate;
  final DateTime maxDate;
  late final List<int> nonEventDays;

  MyProgrammeAgenda({
    Key? key,
    required this.minDate,
    required this.maxDate,
  }) : super(key: key) {
    final Set<int> allDays = List<int>.generate(7, (i) => i).toSet();
    final Set<int> eventDays = List<int>.generate(
      maxDate.weekday + 7 - minDate.weekday,
      (i) => (minDate.weekday + i) % 7,
    ).toSet();
    nonEventDays = allDays.difference(eventDays).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterProgrammeBloc, FilterProgrammeState>(
      builder: (context, state) {
        return SfCalendar(
          allowedViews: const [
            CalendarView.workWeek,
            CalendarView.schedule,
          ],
          view: CalendarView.workWeek,
          firstDayOfWeek: minDate.weekday,
          timeSlotViewSettings: TimeSlotViewSettings(
            startHour: 6,
            // endHour: 24,
            nonWorkingDays: nonEventDays,
          ),
          minDate: minDate,
          maxDate: maxDate,
          dataSource: AgendaDataSource(
            state.programmeEntriesFiltered,
            context.watch<LocalizationBloc>().state.appLang,
          ),
        );
      },
    );
  }
}

class AgendaDataSource extends CalendarDataSource {
  List<ProgEntry> programmeEntries;
  final AppLang lang;

  AgendaDataSource(this.programmeEntries, this.lang);

  @override
  List<dynamic> get appointments => programmeEntries;

  @override
  DateTime getStartTime(int index) {
    return programmeEntries[index].timestamp;
  }

  @override
  DateTime getEndTime(int index) {
    return programmeEntries[index]
        .timestamp
        .add(Duration(minutes: programmeEntries[index].duration));
  }

  @override
  String getSubject(int index) {
    Map<String, String> name = programmeEntries[index].name;
    return name[modelAppLang[lang]] ?? name['@en'] ?? 'Undef.';
  }

  @override
  bool isAllDay(int index) {
    return false;
  }
}
