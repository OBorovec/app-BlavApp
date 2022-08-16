part of 'contacts_bloc.dart';

enum ContactsStatus {
  initial,
  loaded,
  error,
}

class ContactsState extends Equatable {
  final ContactsStatus status;
  final String message;
  final Contacts contacts;

  const ContactsState({
    this.status = ContactsStatus.initial,
    this.message = '',
    this.contacts = const Contacts(),
  });

  Map<String, ContactEntity> get contactEntities => contacts.entities;

  @override
  List<Object> get props => [status, message, contacts];

  ContactsState copyWith({
    ContactsStatus? status,
    String? message,
    Contacts? contacts,
  }) {
    return ContactsState(
      status: status ?? this.status,
      message: message ?? this.message,
      contacts: contacts ?? this.contacts,
    );
  }
}
