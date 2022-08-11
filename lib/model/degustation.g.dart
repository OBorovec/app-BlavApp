// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'degustation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Degustation _$DegustationFromJson(Map<String, dynamic> json) => Degustation(
      desc: (json['desc'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => DegusItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      places: (json['places'] as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, DegusPlace.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
      notifications: (json['notifications'] as List<dynamic>?)
              ?.map(
                  (e) => DegusNotification.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$DegustationToJson(Degustation instance) =>
    <String, dynamic>{
      'desc': instance.desc,
      'items': instance.items,
      'places': instance.places,
      'notifications': instance.notifications,
    };

DegusItem _$DegusItemFromJson(Map<String, dynamic> json) => DegusItem(
      id: json['id'] as String,
      name: Map<String, String>.from(json['name'] as Map),
      desc: (json['desc'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      rating: (json['rating'] as num?)?.toDouble() ?? -1,
      alcoholVolume: (json['alcoholVolume'] as num?)?.toDouble(),
      placeRef:
          (json['placeRef'] as List<dynamic>).map((e) => e as String).toList(),
      alcoholType: $enumDecode(_$DegusAlcoholTypeEnumMap, json['alcoholType']),
      subType: json['subType'] as String?,
      dSubType: (json['dSubType'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      price: json['price'] as int,
      volumes: (json['volumes'] as List<dynamic>?)
              ?.map((e) => DegusVolume.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      origin: json['origin'] as String?,
      similarItems: (json['similarItems'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$DegusItemToJson(DegusItem instance) => <String, dynamic>{
      'id': instance.id,
      'placeRef': instance.placeRef,
      'name': instance.name,
      'desc': instance.desc,
      'rating': instance.rating,
      'alcoholVolume': instance.alcoholVolume,
      'alcoholType': _$DegusAlcoholTypeEnumMap[instance.alcoholType],
      'subType': instance.subType,
      'dSubType': instance.dSubType,
      'price': instance.price,
      'volumes': instance.volumes,
      'images': instance.images,
      'origin': instance.origin,
      'similarItems': instance.similarItems,
    };

const _$DegusAlcoholTypeEnumMap = {
  DegusAlcoholType.mead: 'mead',
};

DegusVolume _$DegusVolumeFromJson(Map<String, dynamic> json) => DegusVolume(
      price: (json['price'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      desc: Map<String, String>.from(json['desc'] as Map),
    );

Map<String, dynamic> _$DegusVolumeToJson(DegusVolume instance) =>
    <String, dynamic>{
      'price': instance.price,
      'desc': instance.desc,
    };

DegusPlace _$DegusPlaceFromJson(Map<String, dynamic> json) => DegusPlace(
      id: json['id'] as String,
      name: Map<String, String>.from(json['name'] as Map),
      loc: json['loc'] == null
          ? null
          : DegusPlaceLoc.fromJson(json['loc'] as Map<String, dynamic>),
      open: (json['open'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$DegusPlaceToJson(DegusPlace instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'loc': instance.loc,
      'open': instance.open,
      'images': instance.images,
    };

DegusPlaceLoc _$DegusPlaceLocFromJson(Map<String, dynamic> json) =>
    DegusPlaceLoc(
      mapRef: json['mapRef'] as String,
      pointRef: json['pointRef'] as String,
    );

Map<String, dynamic> _$DegusPlaceLocToJson(DegusPlaceLoc instance) =>
    <String, dynamic>{
      'mapRef': instance.mapRef,
      'pointRef': instance.pointRef,
    };

DegusNotification _$DegusNotificationFromJson(Map<String, dynamic> json) =>
    DegusNotification(
      parrentId: json['parrentId'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
      message: Map<String, String>.from(json['message'] as Map),
    );

Map<String, dynamic> _$DegusNotificationToJson(DegusNotification instance) =>
    <String, dynamic>{
      'parrentId': instance.parrentId,
      'timestamp': instance.timestamp.toIso8601String(),
      'message': instance.message,
    };
