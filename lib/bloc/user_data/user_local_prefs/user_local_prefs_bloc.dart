import 'package:blavapp/services/prefs_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_local_prefs_event.dart';
part 'user_local_prefs_state.dart';

class UserLocalPrefsBloc
    extends Bloc<UserLocalPrefsEvent, UserLocalPrefsState> {
  final PrefsRepo _prefs;
  UserLocalPrefsBloc({
    required PrefsRepo prefs,
    required UserLocalPrefsState initState,
  })  : _prefs = prefs,
        super(initState) {
    on<SetCZKUserCurrencyPref>(
        (event, emit) => setCurrency(UserCurrencyPref.czk, emit));
    on<SetEURUserCurrencyPref>(
        (event, emit) => setCurrency(UserCurrencyPref.eur, emit));
  }

  setCurrency(
    UserCurrencyPref currency,
    Emitter<UserLocalPrefsState> emit,
  ) {
    _prefs.saveUserCurrency(currency.toString());
    emit(
      UserLocalPrefsState(
        currency: currency,
      ),
    );
  }

  static UserLocalPrefsState load(PrefsRepo prefs) {
    final String? currencyUserPref = prefs.loadUserCurrency();
    if (currencyUserPref == UserCurrencyPref.czk.toString()) {
      return const UserLocalPrefsState(
        currency: UserCurrencyPref.czk,
      );
    } else if (currencyUserPref == UserCurrencyPref.eur.toString()) {
      return const UserLocalPrefsState(
        currency: UserCurrencyPref.eur,
      );
    } else {
      return const UserLocalPrefsState(
        currency: UserCurrencyPref.czk,
      );
    }
  }
}
