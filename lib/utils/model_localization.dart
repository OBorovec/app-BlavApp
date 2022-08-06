import 'package:blavapp/bloc/app/localization/localization_bloc.dart';
import 'package:blavapp/model/catering.dart';
import 'package:blavapp/model/degustation.dart';
import 'package:blavapp/model/programme.dart';
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
    case ProgEntryType.show:
      return AppLocalizations.of(context)!.programmeTypeShow;
    case ProgEntryType.degustation:
      return AppLocalizations.of(context)!.programmeTypeDegustation;
    case ProgEntryType.discussion:
      return AppLocalizations.of(context)!.programmeTypeDiscussion;
    case ProgEntryType.gaming:
      return AppLocalizations.of(context)!.programmeTypeGaming;
    case ProgEntryType.photo:
      return AppLocalizations.of(context)!.programmeTypePhoto;
    case ProgEntryType.cosplay:
      return AppLocalizations.of(context)!.programmeTypeCosplay;
    case ProgEntryType.other:
      return AppLocalizations.of(context)!.programmeTypeOther;
  }
}

String tCaterItemType(CaterItemType itemType, BuildContext context) {
  switch (itemType) {
    case CaterItemType.starter:
      return AppLocalizations.of(context)!.cateringTypeStarter;
    case CaterItemType.soup:
      return AppLocalizations.of(context)!.cateringTypeSoup;
    case CaterItemType.snack:
      return AppLocalizations.of(context)!.cateringTypeSnack;
    case CaterItemType.main:
      return AppLocalizations.of(context)!.cateringTypeMain;
    case CaterItemType.side:
      return AppLocalizations.of(context)!.cateringTypeSide;
    case CaterItemType.drink:
      return AppLocalizations.of(context)!.cateringTypeDrink;
    case CaterItemType.desert:
      return AppLocalizations.of(context)!.cateringTypeDesert;
    default:
      return 'Unknown';
  }
}

String tDegusAlcoholType(DegusAlcoholType type, BuildContext context) {
  switch (type) {
    case DegusAlcoholType.mead:
      return AppLocalizations.of(context)!.degusAlcoholTypeMead;
    default:
      return 'Unknown';
  }
}
