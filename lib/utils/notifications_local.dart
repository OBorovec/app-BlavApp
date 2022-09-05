import 'package:blavapp/bloc/programme/data_programme/programme_bloc.dart';
import 'package:blavapp/bloc/user_data/user_data/user_data_bloc.dart';
import 'package:blavapp/bloc/user_data/user_local_prefs/user_local_prefs_bloc.dart';
import 'package:blavapp/model/programme.dart';
import 'package:blavapp/services/local_notification_service.dart';
import 'package:blavapp/utils/model_helper.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void localNotificationToggle(bool? value, BuildContext context) {
  LocalNotificationService().cancelAllNotifications();
  if (value == true) {
    addAllProgrammeNotification(
      userNotifications:
          BlocProvider.of<UserDataBloc>(context).state.userData.myNotifications,
      userProgramme:
          BlocProvider.of<UserDataBloc>(context).state.userData.myProgramme,
      entries: BlocProvider.of<ProgrammeBloc>(context).state.entries,
      localPrefs: BlocProvider.of<UserLocalPrefsBloc>(context).state,
      context: context,
    );
  }
}

void addAllProgrammeNotification({
  required Set<String> userNotifications,
  required Set<String> userProgramme,
  required Map<String, ProgEntry> entries,
  required UserLocalPrefsState localPrefs,
  required BuildContext context,
}) {
  for (String entryId in userNotifications) {
    if (entries.containsKey(entryId)) {
      final ProgEntry entry = entries[entryId]!;
      if (entry.timestamp.isAfter(DateTime.now())) {
        _addProgrammeEntryNotification(
          entry: entry,
          inUserProgramme: userProgramme.contains(entryId),
          localPrefs: localPrefs,
          context: context,
        );
      }
    }
  }
}

void programmeEntryNotificationToggle({
  required String entryId,
  required BuildContext context,
  bool? value,
}) {
  Map<String, ProgEntry> entries =
      BlocProvider.of<ProgrammeBloc>(context).state.entries;
  if (entries.containsKey(entryId)) {
    final ProgEntry entry = entries[entryId]!;
    Set<String> userNotifications =
        BlocProvider.of<UserDataBloc>(context).state.userData.myNotifications;
    Set<String> userProgramme =
        BlocProvider.of<UserDataBloc>(context).state.userData.myProgramme;
    UserLocalPrefsState localPrefs =
        BlocProvider.of<UserLocalPrefsBloc>(context).state;
    bool actionAdd = value ?? userNotifications.contains(entry.id);
    if (actionAdd) {
      _addProgrammeEntryNotification(
        entry: entry,
        inUserProgramme: userProgramme.contains(entry.id),
        localPrefs: localPrefs,
        context: context,
      );
    } else {
      _removeProgrammeEntryNotification(entry: entry);
    }
  }
}

// Programme support

String _programmeNotificationBodyText(
  bool inUserProgramme,
  int offset,
  BuildContext context,
) {
  final String mainBodyText = inUserProgramme
      ? AppLocalizations.of(context)!.notificationProgrammeMy
      : AppLocalizations.of(context)!.notificationProgramme;
  return '$mainBodyText $offset ${AppLocalizations.of(context)!.genMinutes}';
}

int _programmeEntryNotificationId(String entryId, int offset) {
  return stringIdToIntId('$entryId-$offset');
}

void _addProgrammeEntryNotification({
  required ProgEntry entry,
  required bool inUserProgramme,
  required UserLocalPrefsState localPrefs,
  required BuildContext context,
}) {
  if (localPrefs.notify10min) {
    LocalNotificationService().scheduleNotification(
      notificationId: _programmeEntryNotificationId(entry.id, 10),
      title: t(entry.name, context),
      body: _programmeNotificationBodyText(inUserProgramme, 10, context),
      triggerAt: entry.timestamp.subtract(const Duration(minutes: 10)),
    );
  }
  if (localPrefs.notify30min) {
    LocalNotificationService().scheduleNotification(
      notificationId: _programmeEntryNotificationId(entry.id, 30),
      title: t(entry.name, context),
      body: _programmeNotificationBodyText(inUserProgramme, 30, context),
      triggerAt: entry.timestamp.subtract(const Duration(minutes: 30)),
    );
  }
  if (localPrefs.notify60min) {
    LocalNotificationService().scheduleNotification(
      notificationId: _programmeEntryNotificationId(entry.id, 60),
      title: t(entry.name, context),
      body: _programmeNotificationBodyText(inUserProgramme, 60, context),
      triggerAt: entry.timestamp.subtract(const Duration(minutes: 60)),
    );
  }
}

void _removeProgrammeEntryNotification({
  required ProgEntry entry,
}) {
  LocalNotificationService().cancelNotification(
    _programmeEntryNotificationId(entry.id, 10),
  );
  LocalNotificationService().cancelNotification(
    _programmeEntryNotificationId(entry.id, 30),
  );
  LocalNotificationService().cancelNotification(
    _programmeEntryNotificationId(entry.id, 60),
  );
}
