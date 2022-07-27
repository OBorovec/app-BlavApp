part of 'localization_bloc.dart';

abstract class LocalizationEvent extends Equatable {
  const LocalizationEvent();

  @override
  List<Object> get props => [];
}

class SetLangCS extends LocalizationEvent {}

class SetLangEN extends LocalizationEvent {}

class ChangeLang extends LocalizationEvent {
  final AppLang appLang;

  const ChangeLang({
    required this.appLang,
  });

  @override
  List<Object> get props => [appLang];
}
