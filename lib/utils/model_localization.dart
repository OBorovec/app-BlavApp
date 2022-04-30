import 'package:blavapp/bloc/localization/localization_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final Map<AppLang, String?> modelAppLang = {
  AppLang.cs: '@cs',
  AppLang.en: '@en',
  AppLang.auto: null,
};

String t(Map<String, String> modelItem, BuildContext context) {
  final AppLang lang = BlocProvider.of<LocalizationBloc>(context).state.appLang;
  final String? langKey = modelAppLang[lang];
  return modelItem[langKey] ?? modelItem['@cs'] ?? 'Loc. missing';
}
