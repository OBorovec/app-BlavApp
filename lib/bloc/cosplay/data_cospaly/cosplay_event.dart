part of 'cosplay_bloc.dart';

abstract class CosplayEvent extends Equatable {
  const CosplayEvent();

  @override
  List<Object> get props => [];
}

class CosplayStreamChanged extends CosplayEvent {
  final Cosplay cosplay;

  const CosplayStreamChanged({
    required this.cosplay,
  });
}

class CosplaySubscriptionFailed extends CosplayEvent {
  final String message;

  const CosplaySubscriptionFailed({required this.message});
}
