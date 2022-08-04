part of 'cosplay_bloc.dart';

abstract class CosplayEvent extends Equatable {
  const CosplayEvent();

  @override
  List<Object> get props => [];
}

class CosplayStreamChanged extends CosplayEvent {
  final List<CosplayRecord> cosplayRecords;

  const CosplayStreamChanged({
    required this.cosplayRecords,
  });
}

class CosplaySubscriptionFailed extends CosplayEvent {
  final String message;

  const CosplaySubscriptionFailed({required this.message});
}
