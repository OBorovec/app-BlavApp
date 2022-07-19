part of 'catering_bloc.dart';

enum CateringStatus {
  initial,
  loaded,
  failed,
}

class CateringState extends Equatable {
  final CateringStatus status;
  final String message;
  final List<CaterItem> cateringItems;

  const CateringState({
    required this.status,
    this.message = '',
    this.cateringItems = const <CaterItem>[],
  });

  @override
  List<Object> get props => [
        status,
        message,
        cateringItems,
      ];

  CateringState copyWith({
    CateringStatus? status,
    String? message,
    List<CaterItem>? cateringItems,
    List<CaterItem>? cateringItemsFiltered,
    Set<CaterItemType>? availableItemTypes,
    Set<String?>? availablePlaces,
    Set<CaterItemType>? itemTypeFilter,
    Set<String>? placesFilter,
    Set<int>? allergensFilter,
    bool? onlyVegetarion,
    bool? onlyVegan,
    bool? onlyGlutenFree,
    String? queryString,
  }) {
    return CateringState(
      status: status ?? this.status,
      message: message ?? this.message,
      cateringItems: cateringItems ?? this.cateringItems,
    );
  }
}
