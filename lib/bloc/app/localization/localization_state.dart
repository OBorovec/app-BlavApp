part of 'localization_bloc.dart';

enum AppLang { auto, cs, en }

class LocalizationState extends Equatable {
  final AppLang appLang;
  final Locale? locale;

  const LocalizationState({
    required this.appLang,
    required this.locale,
  });

  @override
  List<Object> get props => [appLang];
}
