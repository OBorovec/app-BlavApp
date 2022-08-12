import 'package:blavapp/bloc/programme/filter_programme/filter_programme_bloc.dart';
import 'package:blavapp/bloc/app/localization/localization_bloc.dart';
import 'package:blavapp/bloc/programme/user_programme_agenda/user_programme_agenda_bloc.dart';
import 'package:blavapp/model/programme.dart';
import 'package:blavapp/route_generator.dart';
import 'package:blavapp/utils/model_colors.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:blavapp/views/programme/programme_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ProgrammeAgenda extends StatelessWidget {
  const ProgrammeAgenda({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProgrammeAgendaBloc, UserProgrammeAgendaState>(
      builder: (context, state) {
        final DateTime maxDate = state.event.dayEnd;
        final DateTime minDate = state.event.dayStart;
        final Set<int> allDays = List<int>.generate(7, (i) => i).toSet();
        final int dayCount = maxDate.difference(minDate).inDays + 1;
        final Set<int> eventDays = List<int>.generate(
          dayCount,
          (i) => (minDate.weekday + i) % 7,
        ).toSet();
        final List<int> nonEventDays = allDays.difference(eventDays).toList();
        return SfCalendar(
          headerHeight: 0,
          allowedViews: const [
            CalendarView.workWeek,
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
            programmeEntries: state.agendaData,
            lang: context.read<LocalizationBloc>().state.appLang,
            context: context,
          ),
          appointmentBuilder: appointmentBuilder,
        );
      },
    );
  }

  Widget appointmentBuilder(BuildContext context,
      CalendarAppointmentDetails calendarAppointmentDetails) {
    final ProgEntry entry = calendarAppointmentDetails.appointments.first;
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        RoutePaths.programmeEntry,
        arguments: ProgrammeDetailsArguments(
          entry: entry,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
            color: colorProgEntryType(entry.type, context),
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              children: [
                Text(
                  t(entry.name, context),
                  style: Theme.of(context).textTheme.subtitle2,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(tProgEntryType(entry.type, context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AgendaDataSource extends CalendarDataSource {
  List<ProgEntry> programmeEntries;
  final AppLang lang;
  final BuildContext context;

  AgendaDataSource({
    required this.programmeEntries,
    required this.lang,
    required this.context,
  });

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
    return t(programmeEntries[index].name, context);
  }

  @override
  String getNotes(int index) {
    return tProgEntryType(programmeEntries[index].type, context);
  }

  @override
  Color getColor(int index) => colorProgEntryType(
        programmeEntries[index].type,
        context,
      );

  @override
  bool isAllDay(int index) {
    return false;
  }
}
