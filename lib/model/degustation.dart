import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'degustation.g.dart';

@JsonSerializable()
class Degustation extends Equatable {
  final List<DegusItem> items;
  final Map<String, DegusPlace> places;
  final List<DegusNotification> notifications;

  const Degustation({
    required this.items,
    this.places = const {},
    this.notifications = const [],
  });

  @override
  List<Object?> get props => [items, places, notifications];

  factory Degustation.fromJson(Map<String, Object?> json) =>
      _$DegustationFromJson(json);

  Map<String, Object?> toJson() => _$DegustationToJson(this);
}

enum DegusAlcoholType {
  mead,
}

@JsonSerializable()
class DegusItem extends Equatable {
  final String id;
  final List<String> placeRef;
  final Map<String, String> name;
  final Map<String, String>? desc;
  final double? rating;
  final double? alcoholVolume;
  final DegusAlcoholType alcoholType;
  final String? subType;
  final Map<String, String>? dSubType;
  final int price;
  final List<DegusVolume> volumes;
  final List<String> images;
  final String? origin;
  final List<String> similarItems;

  const DegusItem({
    required this.id,
    required this.name,
    this.desc,
    this.rating,
    this.alcoholVolume,
    required this.placeRef,
    required this.alcoholType,
    this.subType,
    this.dSubType,
    required this.price,
    this.volumes = const [],
    this.images = const [],
    this.origin,
    this.similarItems = const [],
  });

  @override
  List<Object?> get props => [id];

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
  final Map<String, String> name;
  final DegusPlaceLoc? loc;
  final Map<String, String>? opens;
  final List<String> images;

  const DegusPlace({
    required this.name,
    required this.loc,
    required this.opens,
    this.images = const [],
  });

  @override
  List<Object?> get props => [name, loc, opens];

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
