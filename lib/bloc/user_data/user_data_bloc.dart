import 'package:blavapp/bloc/auth/auth_bloc.dart';
import 'package:blavapp/model/user_data.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'dart:async';

part 'user_data_event.dart';
part 'user_data_state.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  final AuthBloc authBloc;
  late final StreamSubscription _authBlocSub;

  UserDataBloc({
    required this.authBloc,
  }) : super(NoUserData()) {
    _authBlocSub = authBloc.stream.listen(_onAuthBlocChange);
    on<EmptyUserData>(_emptyUserData);
    on<LoadUserData>(_loadUserData);
  }

  void _onAuthBlocChange(AuthState event) {}

  FutureOr<void> _emptyUserData(
      EmptyUserData event, Emitter<UserDataState> emit) {}

  FutureOr<void> _loadUserData(
      LoadUserData event, Emitter<UserDataState> emit) {}

  @override
  Future<void> close() {
    _authBlocSub.cancel();
    return super.close();
  }
}
