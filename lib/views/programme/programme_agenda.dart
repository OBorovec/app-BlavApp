import 'dart:math';

import 'package:blavapp/bloc/app/localization/localization_bloc.dart';
import 'package:blavapp/bloc/programme/user_programme_agenda/user_programme_agenda_bloc.dart';
import 'package:blavapp/bloc/user_data/user_data/user_data_bloc.dart';
import 'package:blavapp/model/programme.dart';
import 'package:blavapp/route_generator.dart';
import 'package:blavapp/utils/model_colors.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:blavapp/views/programme/programme_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

// TODO: SfCalendar blocks gesture detection, find a workaround

class ProgrammeAgenda extends StatelessWidget {
  const ProgrammeAgenda({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return BlocBuilder<UserProgrammeAgendaBloc, UserProgrammeAgendaState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.9,
                child: SfCalendar(
                  headerHeight: 0,
                  allowedViews: const [
                    CalendarView.workWeek,
                  ],
                  view: CalendarView.workWeek,
                  firstDayOfWeek: state.minDate!.weekday,
                  timeSlotViewSettings: TimeSlotViewSettings(
                    startHour: max(state.minHour - 1, 0),
                    endHour: min(state.maxHour + 1, 24),
                    nonWorkingDays: state.nonEventDays!,
                    timeIntervalHeight: state.singleDayMod ? 128 : -1,
                  ),
                  minDate: state.minDate!,
                  maxDate: state.maxDate!,
                  dataSource: AgendaDataSource(
                    agendaData: state.agendaData,
                    lang: context.read<LocalizationBloc>().state.appLang,
                    context: context,
                  ),
                  appointmentBuilder: appointmentBuilder,
                  onTap: (details) => calendarTapped(details, context),
                ),
              ),
              const SizedBox(height: 80)
            ],
          ),
        );
      },
    );
  }

  Widget appointmentBuilder(
    BuildContext context,
    CalendarAppointmentDetails calendarAppointmentDetails,
  ) {
    final AgendaData data = calendarAppointmentDetails.appointments.first;
    return InkWell(
      onLongPress: () => Navigator.pushNamed(
        context,
        RoutePaths.programmeEntry,
        arguments: ProgrammeDetailsArguments(
          entry: data.entry,
        ),
      ),
      onDoubleTap: () => BlocProvider.of<UserDataBloc>(context).add(
        UserDataMyProgramme(
          entryId: data.entry.id,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
            color: data.colored
                ? colorProgEntryType(data.entry.type, context)
                : Colors.grey,
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              children: [
                Text(
                  t(data.entry.name, context),
                  style: Theme.of(context).textTheme.subtitle2,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(tProgrammeEntryType(data.entry.type, context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void calendarTapped(CalendarTapDetails details, BuildContext context) {
    if (details.targetElement == CalendarElement.viewHeader) {
      BlocProvider.of<UserProgrammeAgendaBloc>(context).add(
        UserAgendaScopeDate(details.date!),
      );
    }
  }
}

class AgendaDataSource extends CalendarDataSource {
  List<AgendaData> agendaData;
  final AppLang lang;
  final BuildContext context;

  AgendaDataSource({
    required this.agendaData,
    required this.lang,
    required this.context,
  });

  @override
  List<dynamic> get appointments => agendaData;

  @override
  DateTime getStartTime(int index) {
    return agendaData[index].entry.timestamp;
  }

  @override
  DateTime getEndTime(int index) {
    return agendaData[index]
        .entry
        .timestamp
        .add(Duration(minutes: agendaData[index].entry.duration));
  }

  @override
  String getSubject(int index) {
    return t(agendaData[index].entry.name, context);
  }

  @override
  String getNotes(int index) {
    return tProgrammeEntryType(agendaData[index].entry.type, context);
  }

  @override
  Color getColor(int index) {
    return agendaData[index].colored
        ? colorProgEntryType(
            agendaData[index].entry.type,
            context,
          )
        : Colors.grey;
  }

  @override
  bool isAllDay(int index) {
    return false;
  }
}
