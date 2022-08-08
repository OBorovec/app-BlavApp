// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cosplay.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cosplay _$CosplayFromJson(Map<String, dynamic> json) => Cosplay(
      cosplayRecords: (json['cosplayRecords'] as List<dynamic>?)
              ?.map((e) => CosplayRecord.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CosplayToJson(Cosplay instance) => <String, dynamic>{
      'cosplayRecords': instance.cosplayRecords,
    };

CosplayRecord _$CosplayRecordFromJson(Map<String, dynamic> json) =>
    CosplayRecord(
      id: json['id'] as String,
      name: Map<String, String>.from(json['name'] as Map),
      voteRef: json['voteRef'] as String,
      desc: (json['desc'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      profileImage: json['profileImage'] as String,
      links: (json['links'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
                $enumDecode(_$CosplayRecordLinkEnumMap, k), e as String),
          ) ??
          const {},
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CosplayRecordToJson(CosplayRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'voteRef': instance.voteRef,
      'desc': instance.desc,
      'links': instance.links
          .map((k, e) => MapEntry(_$CosplayRecordLinkEnumMap[k], e)),
      'profileImage': instance.profileImage,
      'images': instance.images,
    };

const _$CosplayRecordLinkEnumMap = {
  CosplayRecordLink.face: 'face',
  CosplayRecordLink.insta: 'insta',
  CosplayRecordLink.twitter: 'twitter',
};
