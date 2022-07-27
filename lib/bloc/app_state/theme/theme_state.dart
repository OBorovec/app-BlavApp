part of 'theme_bloc.dart';

enum AppTheme { dark, light, pink }

class ThemeState extends Equatable {
  final AppTheme appTheme;
  final ThemeData themeData;

  const ThemeState({
    required this.appTheme,
    required this.themeData,
  });

  @override
  List<Object> get props => [appTheme];
}
