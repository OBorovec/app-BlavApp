part of 'degustation_bloc.dart';

abstract class DegustationState extends Equatable {
  const DegustationState();

  @override
  List<Object> get props => [];
}

class DegustationInitial extends DegustationState {}

class DegustationFailState extends DegustationState {
  final String message;
  const DegustationFailState(this.message);
}

class DegustationLoaded extends DegustationState {
  final List<DegusItem> degustationItems;

  const DegustationLoaded({
    required this.degustationItems,
  });

  @override
  List<Object> get props => [];

  DegustationLoaded copyWith({
    List<DegusItem>? degustationItems,
  }) {
    return DegustationLoaded(
      degustationItems: degustationItems ?? this.degustationItems,
    );
  }
}
