part of 'contacts_bloc.dart';

enum DataStatus {
  initial,
  loaded,
  error,
}

class ContactsState extends Equatable {
  final DataStatus status;
  final String message;
  final Contacts contacts;

  const ContactsState({
    this.status = DataStatus.initial,
    this.message = '',
    this.contacts = const Contacts(),
  });

  Map<String, ContactEntity> get contactEntities => contacts.entities;

  @override
  List<Object> get props => [status, message, contacts];

  ContactsState copyWith({
    DataStatus? status,
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
