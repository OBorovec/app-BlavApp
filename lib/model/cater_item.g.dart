// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cater_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaterItem _$CaterItemFromJson(Map<String, dynamic> json) => CaterItem(
      id: json['id'] as String,
      name: Map<String, String>.from(json['name'] as Map),
      type: $enumDecode(_$CaterItemTypeEnumMap, json['type']),
      desc: (json['desc'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      sDesc: (json['sDesc'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      placeRef: json['placeRef'] as String?,
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
      volumes: (json['volumes'] as List<dynamic>)
          .map((e) => CatVolume.fromJson(e as Map<String, dynamic>))
          .toList(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toSet() ??
          const {},
    );

Map<String, dynamic> _$CaterItemToJson(CaterItem instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$CaterItemTypeEnumMap[instance.type],
      'desc': instance.desc,
      'sDesc': instance.sDesc,
      'placeRef': instance.placeRef,
      'allergens': instance.allergens,
      'vegetarian': instance.vegetarian,
      'vegan': instance.vegan,
      'glutenFree': instance.glutenFree,
      'images': instance.images,
      'volumes': instance.volumes,
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
};

CatVolume _$CatVolumeFromJson(Map<String, dynamic> json) => CatVolume(
      price: (json['price'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      desc: Map<String, String>.from(json['desc'] as Map),
    );

Map<String, dynamic> _$CatVolumeToJson(CatVolume instance) => <String, dynamic>{
      'price': instance.price,
      'desc': instance.desc,
    };
