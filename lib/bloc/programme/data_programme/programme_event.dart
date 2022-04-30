part of 'programme_bloc.dart';

abstract class ProgrammeEvent extends Equatable {
  const ProgrammeEvent();

  @override
  List<Object> get props => [];
}

class ProgrammeStreamChanged extends ProgrammeEvent {
  final Programme programme;

  const ProgrammeStreamChanged({
    required this.programme,
  });
}

class ProgrammeSubscriptionFailed extends ProgrammeEvent {
  final String message;

  const ProgrammeSubscriptionFailed({required this.message});
}
