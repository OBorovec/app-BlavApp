part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class SetLightTheme extends ThemeEvent {
  const SetLightTheme();
}

class SetDarkTheme extends ThemeEvent {
  const SetDarkTheme();
}

class SetPinkTheme extends ThemeEvent {
  const SetPinkTheme();
}
