import 'package:blavapp/bloc/app/localization/localization_bloc.dart';
import 'package:blavapp/bloc/programme/data_programme/programme_bloc.dart';
import 'package:blavapp/bloc/user_data/user_data/user_data_bloc.dart';
import 'package:blavapp/model/programme.dart';
import 'package:blavapp/services/push_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void pushNotificationToggle(bool? value, BuildContext context) {
  PushNotificationService().unsubscribeAll();
  if (value == true) {
    addAllProgrammeSubscriptions(
        appLang: BlocProvider.of<LocalizationBloc>(context).state.appLang,
        userProgramme:
            BlocProvider.of<UserDataBloc>(context).state.userData.myProgramme,
        entries: BlocProvider.of<ProgrammeBloc>(context).state.entries);
  }
}

void addAllProgrammeSubscriptions({
  required AppLang appLang,
  required Set<String> userProgramme,
  required Map<String, ProgrammeEntry> entries,
}) {
  for (String entryId in userProgramme) {
    if (entries.containsKey(entryId)) {
      final ProgrammeEntry entry = entries[entryId]!;
      _programmeEntrySubscribe(
        appLang: appLang,
        entryId: entry.id,
      );
    }
  }
}

void programmeEntryPushNotificationToggle({
  required String entryId,
  required BuildContext context,
  bool? value,
}) {
  Map<String, ProgrammeEntry> entries =
      BlocProvider.of<ProgrammeBloc>(context).state.entries;
  AppLang appLang = BlocProvider.of<LocalizationBloc>(context).state.appLang;

  if (entries.containsKey(entryId)) {
    final ProgrammeEntry entry = entries[entryId]!;
    Set<String> userProgramme =
        BlocProvider.of<UserDataBloc>(context).state.userData.myProgramme;
    bool actionAdd = value ?? userProgramme.contains(entry.id);
    if (actionAdd) {
      _programmeEntrySubscribe(
        appLang: appLang,
        entryId: entry.id,
      );
    } else {
      _programmeEntryUnsubscribe(
        appLang: appLang,
        entryId: entry.id,
      );
    }
  }
}

// Programme support

void _programmeEntrySubscribe({
  required AppLang appLang,
  required String entryId,
}) {
  PushNotificationService().subscribeTo('$appLang-$entryId');
}

void _programmeEntryUnsubscribe({
  required AppLang appLang,
  required String entryId,
}) {
  PushNotificationService().unsubscribeFrom('$appLang-$entryId');
}
