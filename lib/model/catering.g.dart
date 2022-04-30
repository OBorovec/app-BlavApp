// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catering.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Catering _$CateringFromJson(Map<String, dynamic> json) => Catering(
      desc: (json['desc'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => CaterItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      places: (json['places'] as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, CaterPlace.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
      notifications: (json['notifications'] as List<dynamic>?)
              ?.map(
                  (e) => CaterNotification.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CateringToJson(Catering instance) => <String, dynamic>{
      'desc': instance.desc,
      'items': instance.items,
      'places': instance.places,
      'notifications': instance.notifications,
    };

CaterItem _$CaterItemFromJson(Map<String, dynamic> json) => CaterItem(
      id: json['id'] as String,
      name: Map<String, String>.from(json['name'] as Map),
      type: $enumDecode(_$CaterItemTypeEnumMap, json['type']),
      volumes: (json['volumes'] as List<dynamic>)
          .map((e) => CaterVolume.fromJson(e as Map<String, dynamic>))
          .toList(),
      desc: (json['desc'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      placeRef: (json['placeRef'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      allergens: (json['allergens'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          const [],
      vegetarian: json['vegetarian'] as bool? ?? false,
      vegan: json['vegan'] as bool? ?? false,
      glutenFree: json['glutenFree'] as bool? ?? false,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toSet() ??
          const {},
    );

Map<String, dynamic> _$CaterItemToJson(CaterItem instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$CaterItemTypeEnumMap[instance.type]!,
      'volumes': instance.volumes,
      'desc': instance.desc,
      'placeRef': instance.placeRef,
      'allergens': instance.allergens,
      'vegetarian': instance.vegetarian,
      'vegan': instance.vegan,
      'glutenFree': instance.glutenFree,
      'images': instance.images,
      'tags': instance.tags.toList(),
    };

const _$CaterItemTypeEnumMap = {
  CaterItemType.starter: 'starter',
  CaterItemType.soup: 'soup',
  CaterItemType.snack: 'snack',
  CaterItemType.main: 'main',
  CaterItemType.side: 'side',
  CaterItemType.drink: 'drink',
  CaterItemType.desert: 'desert',
  CaterItemType.other: 'other',
};

CaterVolume _$CaterVolumeFromJson(Map<String, dynamic> json) => CaterVolume(
      price: (json['price'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      desc: Map<String, String>.from(json['desc'] as Map),
    );

Map<String, dynamic> _$CaterVolumeToJson(CaterVolume instance) =>
    <String, dynamic>{
      'price': instance.price,
      'desc': instance.desc,
    };

CaterPlace _$CaterPlaceFromJson(Map<String, dynamic> json) => CaterPlace(
      id: json['id'] as String,
      name: Map<String, String>.from(json['name'] as Map),
      loc: json['loc'] == null
          ? null
          : CaterPlaceLoc.fromJson(json['loc'] as Map<String, dynamic>),
      open: (json['open'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CaterPlaceToJson(CaterPlace instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'loc': instance.loc,
      'open': instance.open,
      'images': instance.images,
    };

CaterPlaceLoc _$CaterPlaceLocFromJson(Map<String, dynamic> json) =>
    CaterPlaceLoc(
      mapRef: json['mapRef'] as String,
      pointRef: json['pointRef'] as String,
    );

Map<String, dynamic> _$CaterPlaceLocToJson(CaterPlaceLoc instance) =>
    <String, dynamic>{
      'mapRef': instance.mapRef,
      'pointRef': instance.pointRef,
    };

CaterNotification _$CaterNotificationFromJson(Map<String, dynamic> json) =>
    CaterNotification(
      parrentId: json['parrentId'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
      message: Map<String, String>.from(json['message'] as Map),
    );

Map<String, dynamic> _$CaterNotificationToJson(CaterNotification instance) =>
    <String, dynamic>{
      'parrentId': instance.parrentId,
      'timestamp': instance.timestamp.toIso8601String(),
      'message': instance.message,
    };
