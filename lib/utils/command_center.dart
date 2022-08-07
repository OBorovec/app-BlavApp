import 'package:blavapp/bloc/app/theme/theme_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

bool cmd(String command, BuildContext context) {
  switch (command) {
    case '!pinky':
      context.read<ThemeBloc>().add(const SetPinkTheme());
      return true;
    default:
      return false;
  }
}
