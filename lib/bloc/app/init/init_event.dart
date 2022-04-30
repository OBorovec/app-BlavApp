part of 'init_bloc.dart';

abstract class InitEvent extends Equatable {
  const InitEvent();

  @override
  List<Object> get props => [];
}

class AuthChanged extends InitEvent {
  final bool isAuth;

  const AuthChanged({
    required this.isAuth,
  });
}

class EventChanged extends InitEvent {
  final bool hasEvent;
  const EventChanged({
    required this.hasEvent,
  });
}

class AnimFinished extends InitEvent {
  const AnimFinished();
}
