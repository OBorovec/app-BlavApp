import 'package:blavapp/bloc/app/event/event_bloc.dart';
import 'package:blavapp/bloc/app/theme/theme_bloc.dart';
import 'package:blavapp/bloc/user_data/user_perms/user_perms_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

bool cmd(String command, BuildContext context) {
  switch (command) {
    case '!pinky':
      context.read<ThemeBloc>().add(const SetPinkTheme());
      return true;
    case '!dev-set-default-event':
      context.read<EventBloc>().add(const EventSetDefault());
      return true;
    case '!dev-set-test-event':
      context.read<EventBloc>().add(const EventSelected(eventID: 'test-event'));
      return true;
    case '!dev-mode':
      context.read<UserPermsBloc>().add(const ToggleDevMode());
      return true;
    default:
      return false;
  }
}
