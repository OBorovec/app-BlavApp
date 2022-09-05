import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'catering.g.dart';

@JsonSerializable()
class Catering extends Equatable {
  final Map<String, String>? desc;
  final Map<String, MealItem> meals;
  final Map<String, BeverageItem> beverages;
  final Map<String, CaterPlace> places;
  final List<CaterNotification> notifications;

  const Catering({
    this.desc,
    this.meals = const {},
    this.beverages = const {},
    this.places = const {},
    this.notifications = const [],
  });

  @override
  List<Object?> get props => [meals, beverages, places, notifications];

  factory Catering.fromJson(Map<String, Object?> json) =>
      _$CateringFromJson(json);

  Map<String, Object?> toJson() => _$CateringToJson(this);
}

enum MealItemType {
  starter,
  soup,
  snack,
  main,
  side,
  desert,
  other,
}

@JsonSerializable()
class MealItem extends Equatable {
  final String id;
  final Map<String, String> name;
  final MealItemType type;
  final List<CaterVolume> volumes;
  final Map<String, String>? desc;
  final List<String> placeRef;
  final List<int> allergens;
  final bool vegetarian;
  final bool vegan;
  final bool glutenFree;
  final List<String> images;
  final Set<String> tags;

  const MealItem({
    required this.id,
    required this.name,
    required this.type,
    required this.volumes,
    this.desc,
    this.placeRef = const [],
    this.allergens = const [],
    this.vegetarian = false,
    this.vegan = false,
    this.glutenFree = false,
    this.images = const [],
    this.tags = const {},
  });

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        desc,
        placeRef,
        allergens,
        vegetarian,
        vegan,
        glutenFree,
        images,
        volumes,
        tags,
      ];

  factory MealItem.fromJson(Map<String, Object?> json) =>
      _$MealItemFromJson(json);
  Map<String, Object?> toJson() => _$MealItemToJson(this);
}

enum BeverageItemType {
  soft,
  beer,
  wine,
  spirit,
  mix,
  tea,
  coffee,
  other,
}

@JsonSerializable()
class BeverageItem extends Equatable {
  final String id;
  final Map<String, String> name;
  final BeverageItemType type;
  final List<CaterVolume> volumes;
  final Map<String, String>? desc;
  final List<String> placeRef;
  final bool hot;
  final bool alcoholic;
  final List<String> images;
  final Set<String> tags;

  const BeverageItem({
    required this.id,
    required this.name,
    required this.type,
    required this.volumes,
    this.desc,
    this.placeRef = const [],
    this.hot = false,
    this.alcoholic = false,
    this.images = const [],
    this.tags = const {},
  });

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        desc,
        placeRef,
        hot,
        alcoholic,
        images,
        volumes,
        tags,
      ];

  factory BeverageItem.fromJson(Map<String, Object?> json) =>
      _$BeverageItemFromJson(json);
  Map<String, Object?> toJson() => _$BeverageItemToJson(this);
}

@JsonSerializable()
class CaterVolume extends Equatable {
  final Map<String, double> price;
  final Map<String, String>? desc;

  const CaterVolume({
    required this.price,
    required this.desc,
  });

  @override
  List<Object?> get props => [price, desc];

  factory CaterVolume.fromJson(Map<String, dynamic> json) =>
      _$CaterVolumeFromJson(json);
  Map<String, dynamic> toJson() => _$CaterVolumeToJson(this);
}

@JsonSerializable()
class CaterPlace extends Equatable {
  final String id;
  final Map<String, String> name;
  final Map<String, String>? desc;
  final CaterPlaceLoc? loc;
  final Map<String, String>? open;
  final List<String> images;

  const CaterPlace({
    required this.id,
    required this.name,
    this.desc,
    required this.loc,
    required this.open,
    this.images = const [],
  });

  @override
  List<Object?> get props => [
        id,
        name,
        desc,
        loc,
        open,
        images,
      ];

  factory CaterPlace.fromJson(Map<String, Object?> json) =>
      _$CaterPlaceFromJson(json);

  Map<String, Object?> toJson() => _$CaterPlaceToJson(this);
}

@JsonSerializable()
class CaterPlaceLoc extends Equatable {
  final String mapRef;
  final String pointRef;

  const CaterPlaceLoc({
    required this.mapRef,
    required this.pointRef,
  });

  @override
  List<Object?> get props => [mapRef, pointRef];

  factory CaterPlaceLoc.fromJson(Map<String, Object?> json) =>
      _$CaterPlaceLocFromJson(json);

  Map<String, Object?> toJson() => _$CaterPlaceLocToJson(this);
}

@JsonSerializable()
class CaterNotification extends Equatable {
  final String? parrentId;
  final DateTime timestamp;
  final Map<String, String> message;

  const CaterNotification({
    required this.parrentId,
    required this.timestamp,
    required this.message,
  });

  @override
  List<Object?> get props => [parrentId, timestamp, message];

  factory CaterNotification.fromJson(Map<String, Object?> json) =>
      _$CaterNotificationFromJson(json);

  Map<String, Object?> toJson() => _$CaterNotificationToJson(this);
}
