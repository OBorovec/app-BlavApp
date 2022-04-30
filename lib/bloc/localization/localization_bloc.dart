import 'dart:async';

import 'package:blavapp/services/prefs_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'localization_event.dart';
part 'localization_state.dart';

enum AppLang { auto, cs, en }

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  final PrefsRepo _prefs;

  LocalizationBloc({
    required PrefsRepo prefs,
    required LocalizationState initState,
  })  : _prefs = prefs,
        super(initState) {
    // Event listeners
    on<ChangeLang>(_changeLang);
    on<SetLangCS>((event, emit) => setLang(
          AppLang.cs,
          const Locale('cs'),
          emit,
        ));
    on<SetLangEN>((event, emit) => setLang(
          AppLang.en,
          const Locale('en'),
          emit,
        ));
  }

  void setLang(
    AppLang appLang,
    Locale locale,
    Function emit,
  ) {
    _prefs.saveTheme(appLang.toString());
    emit(
      LocalizationState(
        appLang: appLang,
        locale: locale,
      ),
    );
  }

  FutureOr<void> _changeLang(
    ChangeLang event,
    Emitter<LocalizationState> emit,
  ) {
    switch (event.appLang) {
      case AppLang.cs:
        emit(const LocalizationState(
          appLang: AppLang.cs,
          locale: Locale('cs'),
        ));
        break;
      case AppLang.en:
        emit(const LocalizationState(
          appLang: AppLang.en,
          locale: Locale('en'),
        ));
        break;
      default:
        emit(const LocalizationState(
          appLang: AppLang.auto,
          locale: null,
        ));
        break;
    }
  }

  static LocalizationState loadLang(PrefsRepo prefs) {
    final String? langPrefValue = prefs.loadLang();
    if (langPrefValue == AppLang.cs.toString()) {
      return const LocalizationState(
        appLang: AppLang.cs,
        locale: Locale('cs'),
      );
    } else if (langPrefValue == AppLang.en.toString()) {
      return const LocalizationState(
        appLang: AppLang.en,
        locale: Locale('en'),
      );
    } else {
      return const LocalizationState(
        appLang: AppLang.auto,
        locale: null,
      );
    }
  }
}
