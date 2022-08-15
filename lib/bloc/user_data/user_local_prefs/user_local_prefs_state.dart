part of 'user_local_prefs_bloc.dart';

enum UserCurrencyPref { czk, eur }

class UserLocalPrefsState extends Equatable {
  final UserCurrencyPref currency;
  final bool allowPushNotifications;
  final bool allowProgrammeNotifications;
  final bool allowStoryNotifications;
  final bool notify10min;
  final bool notify30min;
  final bool notify60min;
  const UserLocalPrefsState({
    this.currency = UserCurrencyPref.czk,
    this.allowPushNotifications = true,
    this.allowProgrammeNotifications = true,
    this.allowStoryNotifications = true,
    this.notify10min = true,
    this.notify30min = false,
    this.notify60min = false,
  });

  @override
  List<Object> get props => [
        currency,
        allowPushNotifications,
        allowProgrammeNotifications,
        allowStoryNotifications,
        notify10min,
        notify30min,
        notify60min,
      ];

  UserLocalPrefsState copyWith({
    UserCurrencyPref? currency,
    bool? allowPushNotifications,
    bool? allowProgrammeNotifications,
    bool? allowStoryNotifications,
    bool? notify10min,
    bool? notify30min,
    bool? notify60min,
  }) {
    return UserLocalPrefsState(
      currency: currency ?? this.currency,
      allowPushNotifications:
          allowPushNotifications ?? this.allowPushNotifications,
      allowProgrammeNotifications:
          allowProgrammeNotifications ?? this.allowProgrammeNotifications,
      allowStoryNotifications:
          allowStoryNotifications ?? this.allowStoryNotifications,
      notify10min: notify10min ?? this.notify10min,
      notify30min: notify30min ?? this.notify30min,
      notify60min: notify60min ?? this.notify60min,
    );
  }
}
