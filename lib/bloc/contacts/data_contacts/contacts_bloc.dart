import 'dart:async';

import 'package:blavapp/bloc/app/event_focus/event_focus_bloc.dart';
import 'package:blavapp/model/contacts.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final DataRepo _dataRepo;
  late final StreamSubscription<EventFocusState> _eventFocusBlocSubscription;
  StreamSubscription<Contacts>? _contactsStream;

  ContactsBloc({
    required DataRepo dataRepo,
    required EventFocusBloc eventFocusBloc,
  })  : _dataRepo = dataRepo,
        super(const ContactsState()) {
    _eventFocusBlocSubscription = eventFocusBloc.stream.listen(
        (EventFocusState eventFocusState) =>
            createDataStream(eventTag: eventFocusState.eventTag));
    if (eventFocusBloc.state.status == EventFocusStatus.focused) {
      createDataStream(eventTag: eventFocusBloc.state.eventTag);
    }
    // Event listeners
    on<ContactsStreamChanged>(_onContactsItemsChange);
    on<ContactsSubscriptionFailed>(_onContactsSubscriptionFailed);
  }

  void createDataStream({required String eventTag}) {
    if (_contactsStream != null) {
      _contactsStream!.cancel();
    }
    _contactsStream = _dataRepo.getContactsStream(eventTag).listen(
          (Contacts contacts) => add(
            ContactsStreamChanged(
              contacts: contacts,
            ),
          ),
        )..onError(
        (error) {
          print('error');
          if (error is NullDataException) {
            add(ContactsSubscriptionFailed(message: error.message));
          } else {
            add(ContactsSubscriptionFailed(message: error.toString()));
          }
        },
      );
  }

  @override
  Future<void> close() {
    _contactsStream?.cancel();
    _eventFocusBlocSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _onContactsItemsChange(
    ContactsStreamChanged event,
    Emitter<ContactsState> emit,
  ) {
    try {
      emit(ContactsState(
        status: ContactsStatus.loaded,
        contacts: event.contacts,
      ));
    } on Exception catch (e) {
      emit(ContactsState(
        status: ContactsStatus.error,
        message: e.toString(),
      ));
    }
  }

  FutureOr<void> _onContactsSubscriptionFailed(
    ContactsSubscriptionFailed event,
    Emitter<ContactsState> emit,
  ) {
    emit(ContactsState(
      status: ContactsStatus.error,
      message: event.message,
    ));
  }
}
