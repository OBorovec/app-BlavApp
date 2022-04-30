import 'package:blavapp/bloc/auth/auth_bloc.dart';
import 'package:blavapp/model/user_prems.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'dart:async';

part 'user_prems_event.dart';
part 'user_prems_state.dart';

class UserPremsBloc extends Bloc<UserPremsEvent, UserPremsState> {
  final AuthBloc authBloc;
  late final StreamSubscription _authBlocSub;

  UserPremsBloc({
    required this.authBloc,
  }) : super(NoUserPrems()) {
    _authBlocSub = authBloc.stream.listen(_onAuthBlocChange);
    on<EmptyUserPrems>(_emptyUserPrems);
    on<LoadUserPrems>(_loadUserPrems);
  }

  void _onAuthBlocChange(AuthState event) {
    if (event is UserAuthenticated) {
      add(
        LoadUserPrems(
          uid: event.user.uid,
        ),
      );
    } else {
      add(EmptyUserPrems());
    }
  }

  FutureOr<void> _emptyUserPrems(
    EmptyUserPrems event,
    Emitter<UserPremsState> emit,
  ) {
    emit(
      NoUserPrems(),
    );
  }

  FutureOr<void> _loadUserPrems(
    LoadUserPrems event,
    Emitter<UserPremsState> emit,
  ) {}

  @override
  Future<void> close() {
    _authBlocSub.cancel();
    return super.close();
  }
}
