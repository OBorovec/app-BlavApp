import 'package:blavapp/bloc/user_data/user_local_prefs/user_local_prefs_bloc.dart';
import 'package:flutter/material.dart';

String prefCurrency(
    UserCurrencyPref currency, Map<String, double> obj, BuildContext context) {
  if (currency == UserCurrencyPref.eur && obj.containsKey('eur')) {
    return '${obj['eur']} eur';
  } else {
    return '${obj['czk']} czk';
  }
}
