import 'dart:async';

import 'package:blavapp/model/event.dart';
import 'package:blavapp/model/ticket.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'ticket_checker_event.dart';
part 'ticket_checker_state.dart';

class TicketCheckerBloc extends Bloc<TicketCheckerEvent, TicketCheckerState> {
  final DataRepo _dataRepo;
  late final List<Event> _events;

  TicketCheckerBloc({
    required DataRepo dataRepo,
  })  : _dataRepo = dataRepo,
        super(const TicketCheckerState()) {
    // Event listeners
    on<LoadEvents>(_loadEvents);
    on<TicketScanned>(_ticketScanned);
    on<TicketRedeem>(_ticketRedeemed);
    on<ScanNextTicket>(_scanNextTicket);
    // Init event
    add(const LoadEvents());
  }

  Future<FutureOr<void>> _loadEvents(
    LoadEvents event,
    Emitter<TicketCheckerState> emit,
  ) async {
    _events = await _dataRepo.getEvents();
  }

  Future<FutureOr<void>> _ticketScanned(
    TicketScanned event,
    Emitter<TicketCheckerState> emit,
  ) async {
    if (event.barcodeValue != null) {
      try {
        final Ticket ticket = await _dataRepo.getTicket(event.barcodeValue!);
        final Event eventRecord = _events.firstWhere(
          (Event e) => e.id == ticket.eventRef,
        );
        emit(TicketCheckerState(
          status: TicketCheckerStatus.ready,
          message: event.barcodeValue ?? 'Empty barcode',
          ticket: ticket,
          event: eventRecord,
        ));
      } catch (e) {
        emit(TicketCheckerState(
          status: TicketCheckerStatus.failed,
          message: 'Unable to load ticket ${event.barcodeValue}',
        ));
      }
    }
  }

  FutureOr<void> _ticketRedeemed(
    TicketRedeem event,
    Emitter<TicketCheckerState> emit,
  ) {}

  FutureOr<void> _scanNextTicket(
    ScanNextTicket event,
    Emitter<TicketCheckerState> emit,
  ) {
    emit(const TicketCheckerState(
      status: TicketCheckerStatus.scanning,
    ));
  }
}
