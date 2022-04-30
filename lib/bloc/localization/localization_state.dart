part of 'localization_bloc.dart';

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
