import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'catering.g.dart';

@JsonSerializable()
class Catering extends Equatable {
  final List<CaterItem> items;
  final Map<String, CaterPlace> places;
  final List<CaterNotification> notifications;

  const Catering({
    required this.items,
    this.places = const {},
    this.notifications = const [],
  });

  @override
  List<Object?> get props => [items, places, notifications];

  factory Catering.fromJson(Map<String, Object?> json) =>
      _$CateringFromJson(json);

  Map<String, Object?> toJson() => _$CateringToJson(this);
}

enum CaterItemType {
  starter,
  soup,
  snack,
  main,
  side,
  drink,
  desert,
  other,
}

@JsonSerializable()
class CaterItem extends Equatable {
  final String id;
  final Map<String, String> name;
  final CaterItemType type;
  final Map<String, String>? desc;
  final Map<String, String>? sDesc;
  final String? placeRef;
  final List<int> allergens;
  final bool vegetarian;
  final bool vegan;
  final bool glutenFree;
  final List<String> images;
  final List<CaterVolume> volumes;
  final Set<String> tags;

  const CaterItem({
    required this.id,
    required this.name,
    required this.type,
    this.desc,
    this.sDesc,
    required this.placeRef,
    this.allergens = const [],
    this.vegetarian = false,
    this.vegan = false,
    this.glutenFree = false,
    this.images = const [],
    required this.volumes,
    this.tags = const {},
  });

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        desc,
        sDesc,
        placeRef,
        allergens,
        vegetarian,
        vegan,
        glutenFree,
        images,
        volumes,
        tags
      ];

  factory CaterItem.fromJson(Map<String, Object?> json) =>
      _$CaterItemFromJson(json);
  Map<String, Object?> toJson() => _$CaterItemToJson(this);
}

@JsonSerializable()
class CaterVolume extends Equatable {
  final Map<String, double> price;
  final Map<String, String> desc;

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
  final Map<String, String> name;
  final String? loc;
  final Map<String, String>? opens;
  final List<String> images;

  const CaterPlace({
    required this.name,
    required this.loc,
    required this.opens,
    this.images = const [],
  });

  @override
  List<Object?> get props => [name, loc, opens];

  factory CaterPlace.fromJson(Map<String, Object?> json) =>
      _$CaterPlaceFromJson(json);

  Map<String, Object?> toJson() => _$CaterPlaceToJson(this);
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
