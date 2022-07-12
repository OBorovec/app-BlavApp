import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cater_item.g.dart';

enum CaterItemType { starter, soup, snack, main, side, drink, desert }

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
  final List<CatVolume> volumes;
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
  List<Object?> get props => [id];

  factory CaterItem.fromJson(Map<String, Object?> json) =>
      _$CaterItemFromJson(json);
  Map<String, Object?> toJson() => _$CaterItemToJson(this);
}

@JsonSerializable()
class CatVolume extends Equatable {
  final Map<String, double> price;
  final Map<String, String> desc;

  const CatVolume({
    required this.price,
    required this.desc,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  factory CatVolume.fromJson(Map<String, dynamic> json) =>
      _$CatVolumeFromJson(json);
  Map<String, dynamic> toJson() => _$CatVolumeToJson(this);
}
