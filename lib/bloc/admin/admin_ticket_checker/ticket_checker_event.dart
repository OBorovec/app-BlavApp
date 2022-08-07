part of 'ticket_checker_bloc.dart';

abstract class TicketCheckerEvent extends Equatable {
  const TicketCheckerEvent();

  @override
  List<Object> get props => [];
}

class LoadEvents extends TicketCheckerEvent {
  const LoadEvents();
}

class TicketScanned extends TicketCheckerEvent {
  final String? barcodeValue;
  const TicketScanned({required this.barcodeValue});
}

class TicketRedeem extends TicketCheckerEvent {
  const TicketRedeem();
}

class ScanNextTicket extends TicketCheckerEvent {
  const ScanNextTicket();
}
