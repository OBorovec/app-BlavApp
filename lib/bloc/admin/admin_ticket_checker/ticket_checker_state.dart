part of 'ticket_checker_bloc.dart';

enum TicketCheckerStatus { scanning, ready, failed }

class TicketCheckerState extends Equatable {
  final TicketCheckerStatus status;
  final String message;
  final Ticket? ticket;
  final Event? event;

  const TicketCheckerState({
    this.status = TicketCheckerStatus.scanning,
    this.message = '',
    this.ticket,
    this.event,
  });

  @override
  List<Object> get props => [status, message, ticket ?? '', event ?? ''];
}
