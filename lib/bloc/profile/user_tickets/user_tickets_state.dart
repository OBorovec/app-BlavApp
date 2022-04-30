part of 'user_tickets_bloc.dart';

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
  final List<TicketData> tickets;
  final List<String> unableToLoad;

  const UserTicketsState({
    this.tickets = const [],
    this.unableToLoad = const [],
  });

  @override
  List<Object> get props => [
        tickets,
        unableToLoad,
      ];
}
