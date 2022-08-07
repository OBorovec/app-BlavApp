import 'dart:async';

import 'package:blavapp/model/event.dart';
import 'package:blavapp/model/ticket.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_tickets_event.dart';
part 'user_tickets_state.dart';

class UserTicketsBloc extends Bloc<UserTicketsEvent, UserTicketsState> {
  final List<String> _tickets;
  final DataRepo _dataRepo;

  UserTicketsBloc({
    required List<String> tickets,
    required DataRepo dataRepo,
  })  : _tickets = tickets,
        _dataRepo = dataRepo,
        super(const UserTicketsState()) {
    // Event listeners
    on<RefreshData>(_refreshData);
    // Init event
    add(const RefreshData());
  }

  Future<FutureOr<void>> _refreshData(
    RefreshData event,
    Emitter<UserTicketsState> emit,
  ) async {
    final List<Event> allEvents = await _dataRepo.getEvents();
    final List<TicketData> ticketData = [];
    final List<String> unableToLoad = [];
    for (String ticketRef in _tickets) {
      try {
        final Ticket ticket = await _dataRepo.getTicket(ticketRef);
        final List<Event> matchEvents =
            allEvents.where((Event e) => e.id == ticket.eventRef).toList();
        if (matchEvents.isNotEmpty) {
          ticketData.add(TicketData(
            ticket: ticket,
            event: matchEvents.first,
          ));
        }
      } catch (e) {
        unableToLoad.add(ticketRef);
      }
    }
    emit(UserTicketsState(
      status: UserTicketsStatus.ready,
      tickets: ticketData,
      unableToLoad: unableToLoad,
    ));
  }
}
