part of 'user_local_prefs_bloc.dart';

enum UserCurrencyPref { czk, eur }

class UserLocalPrefsState extends Equatable {
  final UserCurrencyPref currency;
  const UserLocalPrefsState({this.currency = UserCurrencyPref.czk});

  @override
  List<Object> get props => [];
}
