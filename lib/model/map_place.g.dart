// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapPlace _$MapPlaceFromJson(Map<String, dynamic> json) => MapPlace(
      id: json['id'] as String,
      name: (json['name'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      desc: (json['desc'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      mapPlacement: json['mapPlacement'] as String,
    );

Map<String, dynamic> _$MapPlaceToJson(MapPlace instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'desc': instance.desc,
      'mapPlacement': instance.mapPlacement,
    };
