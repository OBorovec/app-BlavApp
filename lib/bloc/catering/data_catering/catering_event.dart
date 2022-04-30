part of 'catering_bloc.dart';

abstract class CateringEvent extends Equatable {
  const CateringEvent();

  @override
  List<Object> get props => [];
}

class CateringStreamChanged extends CateringEvent {
  final Catering catering;
  const CateringStreamChanged({
    required this.catering,
  });
}

class CateringSubscriptionFailed extends CateringEvent {
  final String message;

  const CateringSubscriptionFailed({required this.message});
}
