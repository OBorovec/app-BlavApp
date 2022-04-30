part of 'user_prems_bloc.dart';

abstract class UserPremsEvent extends Equatable {
  const UserPremsEvent();

  @override
  List<Object> get props => [];
}

class EmptyUserPrems extends UserPremsEvent {}

class LoadUserPrems extends UserPremsEvent {
  final String uid;

  const LoadUserPrems({
    required this.uid,
  });

  @override
  List<Object> get props => [uid];
}
