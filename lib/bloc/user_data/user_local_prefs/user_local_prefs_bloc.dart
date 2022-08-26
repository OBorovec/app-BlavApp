import 'dart:async';

import 'package:blavapp/services/prefs_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_local_prefs_event.dart';
part 'user_local_prefs_state.dart';

const UserCurrencyPref defCurrency = UserCurrencyPref.czk;

class UserLocalPrefsBloc
    extends Bloc<UserLocalPrefsEvent, UserLocalPrefsState> {
  final PrefsRepo _prefs;
  UserLocalPrefsBloc({
    required PrefsRepo prefs,
    required UserLocalPrefsState initState,
  })  : _prefs = prefs,
        super(initState) {
    // Event listeners
    on<SetUserCurrencyPref>(_setUserCurrencyPref);
    on<AllowUserPushNotification>(_allowUserPushNotification);
    on<AllowUserProgrammeNotification>(_allowUserProgrammeNotification);
    on<AllowUserStoryNotification>(_allowUserStoryNotification);
    on<Toggle10minNotification>(_toggle10minNotification);
    on<Toggle30minNotification>(_toggle30minNotification);
    on<Toggle60minNotification>(_toggle60minNotification);
  }

  static UserLocalPrefsState load(PrefsRepo prefs) {
    UserLocalPrefsState state = const UserLocalPrefsState();

    final String? currencyUserPref = prefs.loadUserCurrency();
    if (currencyUserPref == UserCurrencyPref.czk.toString()) {
      state = state.copyWith(
        currency: UserCurrencyPref.czk,
      );
    } else if (currencyUserPref == UserCurrencyPref.eur.toString()) {
      state = state.copyWith(
        currency: UserCurrencyPref.eur,
      );
    } else {
      state = state.copyWith(currency: defCurrency);
    }

    final bool? allowPushNotifications = prefs.loadUserNotificationPush();
    final bool? allowProgrammeNotifications =
        prefs.loadUserNotificationProgramme();
    final bool? allowStoryNotifications = prefs.loadUserNotificationStory();
    state = state.copyWith(
      allowPushNotifications: allowPushNotifications ?? true,
      allowProgrammeNotifications: allowProgrammeNotifications ?? true,
      allowStoryNotifications: allowStoryNotifications ?? true,
    );
    return state;
  }

  FutureOr<void> _setUserCurrencyPref(
    SetUserCurrencyPref event,
    Emitter<UserLocalPrefsState> emit,
  ) {
    _prefs.saveUserCurrency(event.currencyPref.toString());
    emit(
      state.copyWith(
        currency: event.currencyPref,
      ),
    );
  }

  FutureOr<void> _allowUserPushNotification(
    AllowUserPushNotification event,
    Emitter<UserLocalPrefsState> emit,
  ) {
    if (event.value == null) {
      _prefs.saveUserNotificationPush(true);
      emit(
        state.copyWith(
          allowPushNotifications: true,
        ),
      );
    } else {
      _prefs.saveUserNotificationPush(event.value!);
      emit(
        state.copyWith(
          allowPushNotifications: event.value!,
        ),
      );
    }
  }

  FutureOr<void> _allowUserProgrammeNotification(
    AllowUserProgrammeNotification event,
    Emitter<UserLocalPrefsState> emit,
  ) {
    if (event.value == null) {
      _prefs.saveUserNotificationProgramme(true);
      emit(
        state.copyWith(
          allowProgrammeNotifications: true,
        ),
      );
    } else {
      _prefs.saveUserNotificationProgramme(event.value!);
      emit(
        state.copyWith(
          allowProgrammeNotifications: event.value!,
        ),
      );
    }
  }

  FutureOr<void> _allowUserStoryNotification(
    AllowUserStoryNotification event,
    Emitter<UserLocalPrefsState> emit,
  ) {
    if (event.value == null) {
      _prefs.saveUserNotificationStory(true);
      emit(
        state.copyWith(
          allowStoryNotifications: true,
        ),
      );
    } else {
      _prefs.saveUserNotificationStory(event.value!);
      emit(
        state.copyWith(
          allowStoryNotifications: event.value!,
        ),
      );
    }
  }

  FutureOr<void> _toggle10minNotification(
    Toggle10minNotification event,
    Emitter<UserLocalPrefsState> emit,
  ) {
    _prefs.saveUserNotification10(!state.notify10min);
    emit(
      state.copyWith(
        notify10min: !state.notify10min,
      ),
    );
  }

  FutureOr<void> _toggle30minNotification(
    Toggle30minNotification event,
    Emitter<UserLocalPrefsState> emit,
  ) {
    _prefs.saveUserNotification30(!state.notify30min);
    emit(
      state.copyWith(
        notify30min: !state.notify30min,
      ),
    );
  }

  FutureOr<void> _toggle60minNotification(
    Toggle60minNotification event,
    Emitter<UserLocalPrefsState> emit,
  ) {
    _prefs.saveUserNotification60(!state.notify60min);
    emit(
      state.copyWith(
        notify60min: !state.notify60min,
      ),
    );
  }
}
