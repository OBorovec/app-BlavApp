part of 'contacts_bloc.dart';

abstract class ContactsEvent extends Equatable {
  const ContactsEvent();

  @override
  List<Object> get props => [];
}

class ContactsStreamChanged extends ContactsEvent {
  final Contacts contacts;

  const ContactsStreamChanged({
    required this.contacts,
  });
}

class ContactsSubscriptionFailed extends ContactsEvent {
  final String message;

  const ContactsSubscriptionFailed({required this.message});
}
