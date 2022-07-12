part of 'catering_bloc.dart';

abstract class CateringEvent extends Equatable {
  const CateringEvent();

  @override
  List<Object> get props => [];
}

class CateringSubscriptionFailed extends CateringEvent {
  final String message;

  const CateringSubscriptionFailed(this.message);
}

class CateringStreamChanged extends CateringEvent {
  final List<CaterItem> cateringItems;

  const CateringStreamChanged({
    required this.cateringItems,
  });
}
