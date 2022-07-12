import 'package:blavapp/bloc/auth/auth_bloc.dart';
import 'package:blavapp/model/user_perms.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'dart:async';

part 'user_perms_event.dart';
part 'user_perms_state.dart';

class UserPermsBloc extends Bloc<UserPermsEvent, UserPermsState> {
  final AuthBloc authBloc;
  late final StreamSubscription _authBlocSub;

  UserPermsBloc({
    required this.authBloc,
  }) : super(const UserPermsState(userPrems: UserPerms())) {
    _authBlocSub = authBloc.stream.listen(_onAuthBlocChange);
    on<EmptyUserPerms>(_emptyUserPerms);
    on<LoadUserPerms>(_loadUserPerms);
  }

  void _onAuthBlocChange(AuthState state) {
    if (state is UserAuthenticated) {
      add(
        LoadUserPerms(
          uid: state.user.uid,
        ),
      );
    } else {
      add(EmptyUserPerms());
    }
  }

  FutureOr<void> _emptyUserPerms(
    EmptyUserPerms event,
    Emitter<UserPermsState> emit,
  ) {
    emit(const UserPermsState(userPrems: UserPerms()));
  }

  FutureOr<void> _loadUserPerms(
    LoadUserPerms event,
    Emitter<UserPermsState> emit,
  ) {}

  @override
  Future<void> close() {
    _authBlocSub.cancel();
    return super.close();
  }
}
