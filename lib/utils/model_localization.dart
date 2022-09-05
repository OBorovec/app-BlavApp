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

String tMealItemType(MealItemType itemType, BuildContext context) {
  switch (itemType) {
    case MealItemType.starter:
      return AppLocalizations.of(context)!.modelMealTypeStarter;
    case MealItemType.soup:
      return AppLocalizations.of(context)!.modelMealTypeSoup;
    case MealItemType.snack:
      return AppLocalizations.of(context)!.modelMealTypeSnack;
    case MealItemType.main:
      return AppLocalizations.of(context)!.modelMealTypeMain;
    case MealItemType.side:
      return AppLocalizations.of(context)!.modelMealTypeSide;
    case MealItemType.desert:
      return AppLocalizations.of(context)!.modelMealTypeDesert;
    default:
      return 'Unknown';
  }
}

String tBeverageItemType(BeverageItemType itemType, BuildContext context) {
  switch (itemType) {
    case BeverageItemType.soft:
      return AppLocalizations.of(context)!.modelBeverageTypeSoft;
    case BeverageItemType.beer:
      return AppLocalizations.of(context)!.modelBeverageTypeBeer;
    case BeverageItemType.wine:
      return AppLocalizations.of(context)!.modelBeverageTypeWine;
    case BeverageItemType.spirit:
      return AppLocalizations.of(context)!.modelBeverageTypeSpirit;
    case BeverageItemType.mix:
      return AppLocalizations.of(context)!.modelBeverageTypeMix;
    case BeverageItemType.tea:
      return AppLocalizations.of(context)!.modelBeverageTypeTea;
    case BeverageItemType.coffee:
      return AppLocalizations.of(context)!.modelBeverageTypeCoffee;
    case BeverageItemType.other:
      return AppLocalizations.of(context)!.modelBeverageTypeOther;
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
