import 'package:blavapp/bloc/app/auth/auth_bloc.dart';
import 'package:blavapp/model/user_perms.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'dart:async';

part 'user_perms_event.dart';
part 'user_perms_state.dart';

class UserPermsBloc extends Bloc<UserPermsEvent, UserPermsState> {
  final DataRepo _dataRepo;
  late final StreamSubscription _authBlocSub;

  UserPermsBloc({
    required DataRepo dataRepo,
    required AuthBloc authBloc,
  })  : _dataRepo = dataRepo,
        super(const UserPermsState(userPrems: UserPerms())) {
    _authBlocSub = authBloc.stream.listen(_onAuthBlocChange);
    on<EmptyUserPerms>(_emptyUserPerms);
    on<LoadUserPerms>(_loadUserPerms);
  }

  void _onAuthBlocChange(AuthState state) {
    if (state.status == AuthStatus.authenticated) {
      add(
        LoadUserPerms(
          uid: state.user!.uid,
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

  Future<FutureOr<void>> _loadUserPerms(
    LoadUserPerms event,
    Emitter<UserPermsState> emit,
  ) async {
    UserPerms perms = await _dataRepo.getUserPerms(event.uid);
    emit(UserPermsState(userPrems: perms));
  }

  @override
  Future<void> close() {
    _authBlocSub.cancel();
    return super.close();
  }
}
