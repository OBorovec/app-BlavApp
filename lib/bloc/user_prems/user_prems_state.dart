part of 'user_prems_bloc.dart';

abstract class UserPremsState extends Equatable {
  const UserPremsState();

  @override
  List<Object> get props => [];
}

class NoUserPrems extends UserPremsState {}

class ActivetUserPrems extends UserPremsState {
  final UserPrems userPrems;

  const ActivetUserPrems({
    required this.userPrems,
  });

  @override
  List<Object> get props => [userPrems];
}
