part of 'user_local_prefs_bloc.dart';

abstract class UserLocalPrefsEvent extends Equatable {
  const UserLocalPrefsEvent();

  @override
  List<Object> get props => [];
}

class SetCZKUserCurrencyPref extends UserLocalPrefsEvent {
  const SetCZKUserCurrencyPref();

  @override
  List<Object> get props => [];
}

class SetEURUserCurrencyPref extends UserLocalPrefsEvent {
  const SetEURUserCurrencyPref();

  @override
  List<Object> get props => [];
}
