import 'package:blavapp/bloc/user_data/user_data/user_data_bloc.dart';
import 'package:blavapp/components/control/button_switch.dart';
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
        return NotificationSwitch(
          isOn: state.userData.myNotifications.contains(entryId),
          onPressed: () {
            BlocProvider.of<UserDataBloc>(context).add(
              UserDataProgMyNotification(
                entryId: entryId,
              ),
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
        return BookmarkSwitch(
          isOn: state.userData.myProgramme.contains(entryId),
          onPressed: () {
            BlocProvider.of<UserDataBloc>(context).add(
              UserDataMyProgramme(
                entryId: entryId,
              ),
            );
          },
        );
      },
    );
  }
}
