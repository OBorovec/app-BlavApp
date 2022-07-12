import 'package:blavapp/bloc/localization/localization_bloc.dart';
import 'package:blavapp/model/prog_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

String tProgEntryType(ProgEntryType type, BuildContext context) {
  switch (type) {
    case ProgEntryType.concert:
      return AppLocalizations.of(context)!.programmeTypeConcert;
    case ProgEntryType.storyline:
      return AppLocalizations.of(context)!.programmeTypeStoryline;
    case ProgEntryType.workshop:
      return AppLocalizations.of(context)!.programmeTypeWorkshop;
    case ProgEntryType.lecture:
      return AppLocalizations.of(context)!.programmeTypeLecture;
    case ProgEntryType.tournament:
      return AppLocalizations.of(context)!.programmeTypeTournament;
    case ProgEntryType.other:
      return AppLocalizations.of(context)!.programmeTypeOther;
  }
}
