import 'dart:async';

import 'package:blavapp/model/event.dart';
import 'package:blavapp/model/user_data.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_tickets_event.dart';
part 'user_tickets_state.dart';

class UserTicketsBloc extends Bloc<UserTicketsEvent, UserTicketsState> {
  final List<Ticket> _tickets;
  final DataRepo _dataRepo;

  UserTicketsBloc({
    required List<Ticket> tickets,
    required DataRepo dataRepo,
  })  : _tickets = tickets,
        _dataRepo = dataRepo,
        super(const UserTicketsState()) {
    // Event listeners
    on<RecalculateData>(_recalculateData);
    // Init event
    add(const RecalculateData());
  }

  Future<FutureOr<void>> _recalculateData(
    RecalculateData event,
    Emitter<UserTicketsState> emit,
  ) async {
    print(_tickets);
    final List<Event> allEvents = await _dataRepo.getEvents();
    List<TicketData> ticketData = [];
    for (Ticket ticket in _tickets) {
      final List<Event> matchEvents =
          allEvents.where((Event e) => e.id == ticket.eventRef).toList();
      if (matchEvents.isNotEmpty) {
        ticketData.add(TicketData(
          ticket: ticket,
          event: matchEvents.first,
        ));
      }
    }
    emit(UserTicketsState(
      status: UserTicketsStatus.ready,
      tickets: ticketData,
    ));
  }
}
