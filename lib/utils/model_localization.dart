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
      return AppLocalizations.of(context)!.modelProgrammeTypeConcert;
    case ProgEntryType.storyline:
      return AppLocalizations.of(context)!.modelProgrammeTypeStoryline;
    case ProgEntryType.workshop:
      return AppLocalizations.of(context)!.modelProgrammeTypeWorkshop;
    case ProgEntryType.lecture:
      return AppLocalizations.of(context)!.modelProgrammeTypeLecture;
    case ProgEntryType.tournament:
      return AppLocalizations.of(context)!.modelProgrammeTypeTournament;
    case ProgEntryType.show:
      return AppLocalizations.of(context)!.modelProgrammeTypeShow;
    case ProgEntryType.degustation:
      return AppLocalizations.of(context)!.modelProgrammeTypeDegustation;
    case ProgEntryType.discussion:
      return AppLocalizations.of(context)!.modelProgrammeTypeDiscussion;
    case ProgEntryType.gaming:
      return AppLocalizations.of(context)!.modelProgrammeTypeGaming;
    case ProgEntryType.cosplay:
      return AppLocalizations.of(context)!.modelProgrammeTypeCosplay;
    case ProgEntryType.other:
      return AppLocalizations.of(context)!.modelProgrammeTypeOther;
  }
}

String tCaterItemType(CaterItemType itemType, BuildContext context) {
  switch (itemType) {
    case CaterItemType.starter:
      return AppLocalizations.of(context)!.modelCateringTypeStarter;
    case CaterItemType.soup:
      return AppLocalizations.of(context)!.modelCateringTypeSoup;
    case CaterItemType.snack:
      return AppLocalizations.of(context)!.modelCateringTypeSnack;
    case CaterItemType.main:
      return AppLocalizations.of(context)!.modelCateringTypeMain;
    case CaterItemType.side:
      return AppLocalizations.of(context)!.modelCateringTypeSide;
    case CaterItemType.drink:
      return AppLocalizations.of(context)!.modelCateringTypeDrink;
    case CaterItemType.desert:
      return AppLocalizations.of(context)!.modelCateringTypeDesert;
    default:
      return 'Unknown';
  }
}

String tDegusAlcoholType(DegusAlcoholType type, BuildContext context) {
  switch (type) {
    case DegusAlcoholType.mead:
      return AppLocalizations.of(context)!.modelDegustationTypeMead;
    default:
      return 'Unknown';
  }
}
