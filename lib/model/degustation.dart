import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'degustation.g.dart';

@JsonSerializable()
class Degustation extends Equatable {
  final Map<String, String>? desc;
  final List<DegusItem> items;
  final Map<String, DegusPlace> places;
  final List<DegusNotification> notifications;

  const Degustation({
    this.desc,
    this.items = const [],
    this.places = const {},
    this.notifications = const [],
  });

  @override
  List<Object?> get props => [desc, items, places, notifications];

  factory Degustation.fromJson(Map<String, Object?> json) =>
      _$DegustationFromJson(json);

  Map<String, Object?> toJson() => _$DegustationToJson(this);
}

enum DegusAlcoholType {
  mead,
  whisky,
  wine,
  bourbon,
  spirit,
}

@JsonSerializable()
class DegusItem extends Equatable {
  final String id;
  final Map<String, String> name;
  final DegusAlcoholType type;
  final List<DegusVolume> volumes;
  final Map<String, String>? desc;
  final List<String> placeRef;
  final double rating;
  final double? alcoholVolume;
  final String? subType;
  final Map<String, String>? dSubType;
  final List<String> images;
  final String? origin;
  final List<String> similarItems;
  final String? url;

  const DegusItem({
    required this.id,
    required this.name,
    required this.type,
    required this.volumes,
    this.desc,
    this.placeRef = const [],
    this.rating = -1,
    this.alcoholVolume,
    this.subType,
    this.dSubType,
    this.images = const [],
    this.origin,
    this.similarItems = const [],
    this.url,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        desc,
        rating,
        alcoholVolume,
        placeRef,
        type,
        subType,
        dSubType,
        volumes,
        images,
        origin,
        similarItems,
        url,
      ];

  factory DegusItem.fromJson(Map<String, Object?> json) =>
      _$DegusItemFromJson(json);
  Map<String, Object?> toJson() => _$DegusItemToJson(this);
}

@JsonSerializable()
class DegusVolume extends Equatable {
  final Map<String, double> price;
  final Map<String, String> desc;

  const DegusVolume({
    required this.price,
    required this.desc,
  });

  @override
  List<Object?> get props => [price, desc];

  factory DegusVolume.fromJson(Map<String, dynamic> json) =>
      _$DegusVolumeFromJson(json);
  Map<String, dynamic> toJson() => _$DegusVolumeToJson(this);
}

@JsonSerializable()
class DegusPlace extends Equatable {
  final String id;
  final Map<String, String> name;
  final DegusPlaceLoc? loc;
  final Map<String, String>? open;
  final List<String> images;

  const DegusPlace({
    required this.id,
    required this.name,
    required this.loc,
    required this.open,
    this.images = const [],
  });

  @override
  List<Object?> get props => [name, loc, open];

  factory DegusPlace.fromJson(Map<String, Object?> json) =>
      _$DegusPlaceFromJson(json);

  Map<String, Object?> toJson() => _$DegusPlaceToJson(this);
}

@JsonSerializable()
class DegusPlaceLoc extends Equatable {
  final String mapRef;
  final String pointRef;

  const DegusPlaceLoc({
    required this.mapRef,
    required this.pointRef,
  });

  @override
  List<Object?> get props => [mapRef, pointRef];

  factory DegusPlaceLoc.fromJson(Map<String, Object?> json) =>
      _$DegusPlaceLocFromJson(json);

  Map<String, Object?> toJson() => _$DegusPlaceLocToJson(this);
}

@JsonSerializable()
class DegusNotification extends Equatable {
  final String? parrentId;
  final DateTime timestamp;
  final Map<String, String> message;

  const DegusNotification({
    required this.parrentId,
    required this.timestamp,
    required this.message,
  });

  @override
  List<Object?> get props => [parrentId, timestamp, message];

  factory DegusNotification.fromJson(Map<String, Object?> json) =>
      _$DegusNotificationFromJson(json);

  Map<String, Object?> toJson() => _$DegusNotificationToJson(this);
}
