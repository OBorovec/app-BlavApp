import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'map_place.g.dart';

@JsonSerializable()
class MapPlace extends Equatable {
  final String id;
  final Map<String, String>? name;
  final Map<String, String>? desc;
  final String mapPlacement;

  const MapPlace({
    required this.id,
    required this.name,
    required this.desc,
    required this.mapPlacement,
  });

  @override
  List<Object?> get props => [id];

  factory MapPlace.fromJson(Map<String, Object?> json) =>
      _$MapPlaceFromJson(json);
  Map<String, Object?> toJson() => _$MapPlaceToJson(this);
}
