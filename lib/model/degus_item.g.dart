// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'degus_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DegusItem _$DegusItemFromJson(Map<String, dynamic> json) => DegusItem(
      id: json['id'] as String,
      name: (json['name'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$DegusItemToJson(DegusItem instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
