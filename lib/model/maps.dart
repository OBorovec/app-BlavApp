import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'maps.g.dart';

@JsonSerializable()
class Maps extends Equatable {
  final Map<String, MapRecord> mapRecords;
  final List<RealWorldRecord> realWorldRecords;

  const Maps({
    this.mapRecords = const {},
    this.realWorldRecords = const [],
  });

  @override
  List<Object?> get props => [mapRecords, realWorldRecords];

  factory Maps.fromJson(Map<String, Object?> json) => _$MapsFromJson(json);
  Map<String, Object?> toJson() => _$MapsToJson(this);
}

@JsonSerializable()
class MapRecord extends Equatable {
  final String id;
  final Map<String, String> name;
  final String image;
  final int w;
  final int h;
  final List<MapPoint> points;

  const MapRecord({
    required this.id,
    required this.name,
    required this.image,
    required this.w,
    required this.h,
    this.points = const [],
  });

  @override
  List<Object?> get props => [image, points];

  factory MapRecord.fromJson(Map<String, Object?> json) =>
      _$MapRecordFromJson(json);
  Map<String, Object?> toJson() => _$MapRecordToJson(this);
}

enum MapPointType { catering, degustation, programme, shop, other }

@JsonSerializable()
class MapPoint extends Equatable {
  final String id;
  final MapPointType type;
  final double x;
  final double y;
  final Map<String, String> name;
  final List<String> images;

  const MapPoint({
    required this.id,
    required this.type,
    required this.x,
    required this.y,
    required this.name,
    this.images = const [],
  });

  @override
  List<Object?> get props => [id];

  factory MapPoint.fromJson(Map<String, Object?> json) =>
      _$MapPointFromJson(json);
  Map<String, Object?> toJson() => _$MapPointToJson(this);
}

@JsonSerializable()
class RealWorldRecord extends Equatable {
  final Map<String, String> name;
  final Map<String, String>? desc;
  final String? image;
  final double lat;
  final double long;

  const RealWorldRecord({
    required this.name,
    this.desc,
    this.image,
    required this.lat,
    required this.long,
  });

  @override
  List<Object?> get props => [
        name,
      ];

  factory RealWorldRecord.fromJson(Map<String, Object?> json) =>
      _$RealWorldRecordFromJson(json);
  Map<String, Object?> toJson() => _$RealWorldRecordToJson(this);
}
