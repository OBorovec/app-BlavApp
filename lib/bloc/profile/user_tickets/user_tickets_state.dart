part of 'user_tickets_bloc.dart';

enum UserTicketsStatus { init, ready }

class TicketData extends Equatable {
  final Ticket ticket;
  final Event event;

  const TicketData({
    required this.ticket,
    required this.event,
  });

  @override
  List<Object> get props => [ticket, event];
}

class UserTicketsState extends Equatable {
  final UserTicketsStatus status;
  final List<TicketData> tickets;

  const UserTicketsState({
    this.status = UserTicketsStatus.init,
    this.tickets = const [],
  });

  @override
  List<Object> get props => [tickets];

  UserTicketsState copyWith({
    UserTicketsStatus? status,
    List<TicketData>? tickets,
  }) {
    return UserTicketsState(
      status: status ?? this.status,
      tickets: tickets ?? this.tickets,
    );
  }
}
