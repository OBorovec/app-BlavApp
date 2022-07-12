part of 'catering_bloc.dart';

abstract class CateringState extends Equatable {
  const CateringState();

  @override
  List<Object> get props => [];
}

class CateringInitial extends CateringState {}

class CateringFailState extends CateringState {
  final String message;
  const CateringFailState(this.message);
}

class CateringLoaded extends CateringState {
  final List<CaterItem> cateringItems;

  const CateringLoaded({
    required this.cateringItems,
  });

  @override
  List<Object> get props => [];

  CateringLoaded copyWith({
    List<CaterItem>? cateringItems,
  }) {
    return CateringLoaded(
      cateringItems: cateringItems ?? this.cateringItems,
    );
  }
}
