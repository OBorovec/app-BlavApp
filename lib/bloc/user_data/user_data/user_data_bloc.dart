import 'package:blavapp/bloc/app/auth/auth_bloc.dart';
import 'package:blavapp/model/user_data.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

part 'user_data_event.dart';
part 'user_data_state.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  final AuthBloc _authBloc;
  final DataRepo _dataRepo;
  late final StreamSubscription _authBlocSub;
  late StreamSubscription<UserData> _userDataSubscription;

  UserDataBloc({
    required AuthBloc authBloc,
    required DataRepo dataRepo,
  })  : _authBloc = authBloc,
        _dataRepo = dataRepo,
        super(const UserDataState(
          dataStatus: DataStatus.inactive,
          userData: UserData(),
        )) {
    _authBlocSub = authBloc.stream.listen(_onAuthBlocChange);
    on<InitUserData>(_initUserData);
    on<EmptyUserData>(_emptyUserData);
    on<SetUserData>(_setUserData);
    on<UserDataMyProgramme>(_progEntryToggleUserData);
    on<UserDataProgMyNotification>(_progNotificationToggleUserData);
    on<UserDataRateItem>(_rateItem);
    on<UserDataDegustationFavorite>(_degustationFavoriteToggle);
    on<UserDataVoteCosplay>(_voteCosplay);
  }

  void _onAuthBlocChange(AuthState state) {
    if (state.status == AuthStatus.authenticated) {
      _userDataSubscription = _dataRepo
          .getUserDataStream(state.user!.uid)
          .listen(_onUserDataChanged);
    } else {
      add(EmptyUserData());
    }
  }

  void _onUserDataChanged(UserData userData) {
    add(
      SetUserData(userData),
    );
  }

  @override
  Future<void> close() {
    _authBlocSub.cancel();
    _userDataSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _initUserData(
    InitUserData event,
    Emitter<UserDataState> emit,
  ) {}

  FutureOr<void> _emptyUserData(
    EmptyUserData event,
    Emitter<UserDataState> emit,
  ) {
    emit(const UserDataState(
      dataStatus: DataStatus.inactive,
      userData: UserData(),
    ));
  }

  FutureOr<void> _setUserData(
    SetUserData event,
    Emitter<UserDataState> emit,
  ) {
    emit(UserDataState(
      dataStatus: DataStatus.active,
      userData: event.userData,
    ));
  }

  FutureOr<void> _progEntryToggleUserData(
    UserDataMyProgramme event,
    Emitter<UserDataState> emit,
  ) {
    if (state.dataStatus == DataStatus.active) {
      final User user = _authBloc.state.user!;
      if (state.userData.myProgramme.contains(event.entryId)) {
        _dataRepo.removeMyProgrammeEntry(user.uid, event.entryId);
      } else {
        _dataRepo.addMyProgrammeEntry(user.uid, event.entryId);
      }
    }
  }

  FutureOr<void> _progNotificationToggleUserData(
    UserDataProgMyNotification event,
    Emitter<UserDataState> emit,
  ) {
    if (state.dataStatus == DataStatus.active) {
      final User user = _authBloc.state.user!;
      if (state.userData.myNotifications.contains(event.entryId)) {
        _dataRepo.removeProgrammeEntryNotification(user.uid, event.entryId);
      } else {
        _dataRepo.addProgrammeEntryNotification(user.uid, event.entryId);
      }
    }
  }

  FutureOr<void> _rateItem(
    UserDataRateItem event,
    Emitter<UserDataState> emit,
  ) {
    final User? user = _authBloc.state.user;
    if (user != null) {
      _dataRepo.addRating(
        userUID: user.uid,
        itemRef: event.itemRef,
        rating: event.rating,
      );
      _dataRepo.setUserRating(
        userUID: user.uid,
        itemRef: event.itemRef,
        rating: event.rating,
      );
    }
  }

  FutureOr<void> _degustationFavoriteToggle(
    UserDataDegustationFavorite event,
    Emitter<UserDataState> emit,
  ) {
    if (state.dataStatus == DataStatus.active) {
      final User user = _authBloc.state.user!;
      if (state.userData.favoriteSamples.contains(event.itemRef)) {
        _dataRepo.removeDegustationFavorite(
          user.uid,
          event.itemRef,
        );
      } else {
        _dataRepo.addDegustationFavorite(
          _authBloc.state.user!.uid,
          event.itemRef,
        );
      }
    }
  }

  FutureOr<void> _voteCosplay(
    UserDataVoteCosplay event,
    Emitter<UserDataState> emit,
  ) {
    final User? user = _authBloc.state.user;
    if (user != null) {
      _dataRepo.addVote(
        voteRef: event.voteRef,
        userUID: user.uid,
        cosplayRef: event.cosplayRef,
        vote: event.vote,
      );
      _dataRepo.setCosplayVote(
        userUID: user.uid,
        cosplayRef: event.cosplayRef,
        vote: event.vote,
      );
    }
  }
}
