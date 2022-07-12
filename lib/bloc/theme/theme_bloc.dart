import 'package:blavapp/constants/theme/dark.dart';
import 'package:blavapp/constants/theme/light.dart';
import 'package:blavapp/constants/theme/pink.dart';
import 'package:blavapp/services/prefs_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final PrefsRepo _prefs;

  ThemeBloc({
    required PrefsRepo prefs,
    required ThemeState initState,
  })  : _prefs = prefs,
        super(initState) {
    // Event listeners
    on<SetLightTheme>((_, emit) async {
      setTheme(AppTheme.light, lightTheme, emit);
    });
    on<SetDarkTheme>((_, emit) async {
      setTheme(AppTheme.dark, darkTheme, emit);
    });
    on<SetPinkTheme>((_, emit) async {
      setTheme(AppTheme.pink, pinkTheme, emit);
    });
  }

  void setTheme(
    AppTheme appTheme,
    ThemeData themeData,
    Function emit,
  ) {
    _prefs.saveTheme(appTheme.toString());
    emit(
      ThemeState(
        appTheme: appTheme,
        themeData: themeData,
      ),
    );
  }

  static ThemeState loadTheme(PrefsRepo prefs) {
    final String? themeValue = prefs.loadTheme();
    if (themeValue == AppTheme.light.toString()) {
      return ThemeState(
        appTheme: AppTheme.light,
        themeData: lightTheme,
      );
    } else if (themeValue == AppTheme.dark.toString()) {
      return ThemeState(
        appTheme: AppTheme.dark,
        themeData: darkTheme,
      );
    } else if (themeValue == AppTheme.pink.toString()) {
      return ThemeState(
        appTheme: AppTheme.pink,
        themeData: pinkTheme,
      );
    } else {
      return ThemeState(
        appTheme: AppTheme.light,
        themeData: lightTheme,
      );
    }
  }
}
