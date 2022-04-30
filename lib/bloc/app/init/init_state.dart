part of 'init_bloc.dart';

class InitState extends Equatable {
  final bool isAuth;
  final bool hasEvent;
  final bool isAnimFinished;

  const InitState({
    this.isAuth = false,
    this.hasEvent = false,
    this.isAnimFinished = false,
  });

  @override
  List<Object> get props => [
        isAuth,
        hasEvent,
        isAnimFinished,
      ];

  InitState copyWith({
    bool? isAuth,
    bool? hasEvent,
    bool? isAnimFinished,
    bool? reqSignIn,
  }) {
    return InitState(
      isAuth: isAuth ?? this.isAuth,
      hasEvent: hasEvent ?? this.hasEvent,
      isAnimFinished: isAnimFinished ?? this.isAnimFinished,
    );
  }
}
