part of 'user_local_prefs_bloc.dart';

abstract class UserLocalPrefsEvent extends Equatable {
  const UserLocalPrefsEvent();

  @override
  List<Object> get props => [];
}

class SetUserCurrencyPref extends UserLocalPrefsEvent {
  final UserCurrencyPref currencyPref;
  const SetUserCurrencyPref(this.currencyPref);
}

class AllowUserPushNotification extends UserLocalPrefsEvent {
  final bool? value;
  const AllowUserPushNotification(this.value);
}

class AllowUserProgrammeNotification extends UserLocalPrefsEvent {
  final bool? value;
  const AllowUserProgrammeNotification(this.value);
}

class AllowUserStoryNotification extends UserLocalPrefsEvent {
  final bool? value;
  const AllowUserStoryNotification(this.value);
}

class Toggle10minNotification extends UserLocalPrefsEvent {
  const Toggle10minNotification();
}

class Toggle30minNotification extends UserLocalPrefsEvent {
  const Toggle30minNotification();
}

class Toggle60minNotification extends UserLocalPrefsEvent {
  const Toggle60minNotification();
}
