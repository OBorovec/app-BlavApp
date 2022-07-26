import 'package:blavapp/bloc/app/auth/auth_bloc.dart';
import 'package:blavapp/bloc/app/event/event_bloc.dart';
import 'package:blavapp/model/support_ticket.dart';
import 'package:blavapp/model/user_data.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:equatable/equatable.dart';

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_data_event.dart';
part 'user_data_state.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  final DataRepo _dataRepo;
  final AuthBloc _authBloc;
  final EventBloc _eventFocusBloc;
  late final StreamSubscription _authBlocSub;
  late StreamSubscription<UserData> _userDataSubscription;

  UserDataBloc({
    required DataRepo dataRepo,
    required AuthBloc authBloc,
    required EventBloc eventFocusBloc,
  })  : _dataRepo = dataRepo,
        _authBloc = authBloc,
        _eventFocusBloc = eventFocusBloc,
        super(const UserDataState(
          dataStatus: DataStatus.inactive,
          userData: UserData(),
        )) {
    _authBlocSub = authBloc.stream.listen(_onAuthBlocChange);
    on<InitUserData>(_initUserData);
    on<EmptyUserData>(_emptyUserData);
    on<SetUserData>(_setUserData);
    on<UserDataMyProgramme>(_myProgrammeToggle);
    on<UserDataProgMyNotification>(_progNotificationToggle);
    on<UserDataDegustationFavorite>(_degustationFavoriteToggle);
    on<UserDataRateItem>(_rateItem);
    on<UserDataVoteCosplay>(_voteCosplay);
    on<UserDataFeedBack>(_feedBack);
    on<UserSupportTicket>(_supportTicketInit);
    on<UserSupportResponse>(_responseTicket);
  }

  void _onAuthBlocChange(AuthState state) {
    if (state.status == AuthStatus.auth) {
      _userDataSubscription = _dataRepo
          .getUserDataStream(state.user!.uid)
          .listen(_onUserDataChanged);
    } else {
      add(const EmptyUserData());
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

  FutureOr<void> _myProgrammeToggle(
    UserDataMyProgramme event,
    Emitter<UserDataState> emit,
  ) {
    if (state.dataStatus == DataStatus.active) {
      final User user = _authBloc.state.user!;
      if (state.userData.myProgramme.contains(event.entryId)) {
        _dataRepo.removeMyProgrammeEntry(user.uid, event.entryId);
        _dataRepo.removeProgrammeEntryNotification(user.uid, event.entryId);
      } else {
        _dataRepo.addMyProgrammeEntry(user.uid, event.entryId);
        _dataRepo.addProgrammeEntryNotification(user.uid, event.entryId);
      }
    }
  }

  FutureOr<void> _progNotificationToggle(
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

  FutureOr<void> _rateItem(
    UserDataRateItem event,
    Emitter<UserDataState> emit,
  ) {
    final User? user = _authBloc.state.user;
    if (user != null) {
      _dataRepo.addRating(
        eventRef: _eventFocusBloc.state.eventTag,
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

  FutureOr<void> _voteCosplay(
    UserDataVoteCosplay event,
    Emitter<UserDataState> emit,
  ) {
    final User? user = _authBloc.state.user;
    if (user != null) {
      _dataRepo.addVote(
        eventRef: _eventFocusBloc.state.eventTag,
        voteRef: event.voteRef,
        userUID: user.uid,
        cosplayRef: event.cosplayRef,
        vote: event.vote,
      );
      _dataRepo.setUserVote(
        userUID: user.uid,
        cosplayRef: event.cosplayRef,
        vote: event.vote,
      );
    }
  }

  FutureOr<void> _feedBack(
    UserDataFeedBack event,
    Emitter<UserDataState> emit,
  ) {
    final User? user = _authBloc.state.user;
    if (user != null) {
      _dataRepo.addReview(
        eventRef: _eventFocusBloc.state.eventTag,
        reference: event.reference,
        rating: event.rating,
        review: event.message + (event.signed ? user.uid : ''),
      );
    }
  }

  Future<FutureOr<void>> _supportTicketInit(
    UserSupportTicket event,
    Emitter<UserDataState> emit,
  ) async {
    final User? user = _authBloc.state.user;
    final SupportTicket ticket = SupportTicket(
      creatorId: user!.uid,
      title: event.title,
      content: [event.message],
    );
    String ticketRef = await _dataRepo.initSuportTicket(
      ticket: ticket,
    );
    _dataRepo.addSupportTicket(
      ticketRef: ticketRef,
      userUID: user.uid,
    );
  }

  FutureOr<void> _responseTicket(
    UserSupportResponse event,
    Emitter<UserDataState> emit,
  ) {
    // TODO: add response to a ticket and set it as pending for admins
  }
}
