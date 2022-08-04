// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maps.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Maps _$MapsFromJson(Map<String, dynamic> json) => Maps(
      mapRecords: (json['mapRecords'] as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, MapRecord.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
      realWorldRecords: (json['realWorldRecords'] as List<dynamic>?)
              ?.map((e) => RealWorldRecord.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$MapsToJson(Maps instance) => <String, dynamic>{
      'mapRecords': instance.mapRecords,
      'realWorldRecords': instance.realWorldRecords,
    };

MapRecord _$MapRecordFromJson(Map<String, dynamic> json) => MapRecord(
      id: json['id'] as String,
      name: Map<String, String>.from(json['name'] as Map),
      image: json['image'] as String,
      w: json['w'] as int,
      h: json['h'] as int,
      points: (json['points'] as List<dynamic>?)
              ?.map((e) => MapPoint.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$MapRecordToJson(MapRecord instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'w': instance.w,
      'h': instance.h,
      'points': instance.points,
    };

MapPoint _$MapPointFromJson(Map<String, dynamic> json) => MapPoint(
      id: json['id'] as String,
      type: $enumDecode(_$MapPointTypeEnumMap, json['type']),
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      name: Map<String, String>.from(json['name'] as Map),
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$MapPointToJson(MapPoint instance) => <String, dynamic>{
      'id': instance.id,
      'type': _$MapPointTypeEnumMap[instance.type],
      'x': instance.x,
      'y': instance.y,
      'name': instance.name,
      'images': instance.images,
    };

const _$MapPointTypeEnumMap = {
  MapPointType.catering: 'catering',
  MapPointType.degustation: 'degustation',
  MapPointType.programme: 'programme',
  MapPointType.shop: 'shop',
  MapPointType.other: 'other',
};

RealWorldRecord _$RealWorldRecordFromJson(Map<String, dynamic> json) =>
    RealWorldRecord(
      name: Map<String, String>.from(json['name'] as Map),
      desc: (json['desc'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      image: json['image'] as String?,
      lat: (json['lat'] as num).toDouble(),
      long: (json['long'] as num).toDouble(),
    );

Map<String, dynamic> _$RealWorldRecordToJson(RealWorldRecord instance) =>
    <String, dynamic>{
      'name': instance.name,
      'desc': instance.desc,
      'image': instance.image,
      'lat': instance.lat,
      'long': instance.long,
    };
