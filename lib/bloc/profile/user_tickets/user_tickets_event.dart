part of 'user_tickets_bloc.dart';

abstract class UserTicketsEvent extends Equatable {
  const UserTicketsEvent();

  @override
  List<Object> get props => [];
}

class RecalculateData extends UserTicketsEvent {
  const RecalculateData();
}
