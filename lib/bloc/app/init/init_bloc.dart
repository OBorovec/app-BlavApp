import 'dart:async';

import 'package:blavapp/bloc/app/auth/auth_bloc.dart';
import 'package:blavapp/bloc/app/event/event_bloc.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'init_event.dart';
part 'init_state.dart';

class InitBloc extends Bloc<InitEvent, InitState> {
  final DataRepo _dataRepo;
  final AuthBloc _authBloc;
  final EventBloc _eventBloc;
  late final StreamSubscription<AuthState> _authBlocSub;
  late final StreamSubscription<EventState> _eventBlocSub;

  InitBloc({
    required DataRepo dataRepo,
    required AuthBloc authBloc,
    required EventBloc eventBloc,
  })  : _dataRepo = dataRepo,
        _authBloc = authBloc,
        _eventBloc = eventBloc,
        super(InitState(
          isAuth: authBloc.state.status == AuthStatus.auth,
          hasEvent: eventBloc.state.status == EventStatus.selected,
        )) {
    _authBlocSub = authBloc.stream.listen(_onAuthBlocChange);
    _eventBlocSub = eventBloc.stream.listen(_onEventBlocChange);
    // Event listeners
    on<AuthChanged>(_onAuthChanged);
    on<EventChanged>(_onEventChanged);
    on<AnimFinished>(_onAnimFinished);
    // Init
    _authBloc.add(const LoadUser());
    Future.delayed(const Duration(seconds: 1), () {
      add(const AnimFinished());
    });
  }

  void _onAuthBlocChange(
    AuthState state,
  ) {
    add(AuthChanged(
      isAuth: state.status == AuthStatus.auth,
    ));
  }

  Future<void> _onEventBlocChange(
    EventState state,
  ) async {
    if (state.status == EventStatus.empty) {
      _eventBloc.add(
        const EventSetDefault(),
      );
    } else if (state.status == EventStatus.selected) {
      add(const EventChanged(
        hasEvent: true,
      ));
    }
  }

  @override
  Future<void> close() {
    _authBlocSub.cancel();
    _eventBlocSub.cancel();
    return super.close();
  }

  FutureOr<void> _onAuthChanged(
    AuthChanged event,
    Emitter<InitState> emit,
  ) {
    emit(state.copyWith(
      isAuth: event.isAuth,
    ));
    if (event.isAuth) {
      _eventBloc.add(const EventLoad());
    }
  }

  FutureOr<void> _onEventChanged(
    EventChanged event,
    Emitter<InitState> emit,
  ) {
    emit(state.copyWith(
      hasEvent: event.hasEvent,
    ));
  }

  FutureOr<void> _onAnimFinished(
    AnimFinished event,
    Emitter<InitState> emit,
  ) {
    emit(state.copyWith(
      isAnimFinished: true,
    ));
  }
}
