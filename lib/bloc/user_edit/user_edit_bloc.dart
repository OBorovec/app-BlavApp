import 'package:blavapp/services/auth_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_edit_event.dart';
part 'user_edit_state.dart';

class UserEditBloc extends Bloc<UserEditEvent, UserEditState> {
  final AuthRepo _authRepo;
  UserEditBloc({
    required AuthRepo authRepo,
  })  : _authRepo = authRepo,
        super(UserEditInitial()) {
    on<UserEditEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
