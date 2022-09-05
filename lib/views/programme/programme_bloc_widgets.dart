import 'package:blavapp/bloc/user_data/user_data/user_data_bloc.dart';
import 'package:blavapp/components/control/button_switch.dart';
import 'package:blavapp/utils/notifications_local.dart';
import 'package:blavapp/utils/notifications_push.dart';
import 'package:blavapp/utils/toasting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProgrammeEntryNotification extends StatelessWidget {
  final String entryId;
  const ProgrammeEntryNotification({
    Key? key,
    required this.entryId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataBloc, UserDataState>(
      builder: (context, state) {
        bool isOn = state.userData.myNotifications.contains(entryId);

        return NotificationSwitch(
          isOn: isOn,
          onPressed: () {
            BlocProvider.of<UserDataBloc>(context).add(
              UserDataProgMyNotification(
                entryId: entryId,
              ),
            );
            programmeEntryNotificationToggle(
              value: !isOn,
              entryId: entryId,
              context: context,
            );
            Toasting.notifyToast(
              context,
              AppLocalizations.of(context)!
                  .toastingProgrammeNotificationChanged,
            );
          },
        );
      },
    );
  }
}

class ProgrammeEntryMyProgramme extends StatelessWidget {
  final String entryId;
  const ProgrammeEntryMyProgramme({
    Key? key,
    required this.entryId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataBloc, UserDataState>(
      builder: (context, state) {
        bool isOn = state.userData.myProgramme.contains(entryId);
        return BookmarkSwitch(
          isOn: isOn,
          onPressed: () {
            BlocProvider.of<UserDataBloc>(context).add(
              UserDataMyProgramme(
                entryId: entryId,
              ),
            );
            programmeEntryPushNotificationToggle(
              value: !isOn,
              entryId: entryId,
              context: context,
            );
          },
        );
      },
    );
  }
}
