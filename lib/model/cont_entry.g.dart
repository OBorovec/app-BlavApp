// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cont_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContEntry _$ContEntryFromJson(Map<String, dynamic> json) => ContEntry(
      id: json['id'] as String,
      name: Map<String, String>.from(json['name'] as Map),
      desc: (json['desc'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      socials: Socials.fromJson(json['socials'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContEntryToJson(ContEntry instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'desc': instance.desc,
      'images': instance.images,
      'socials': instance.socials,
    };

Socials _$SocialsFromJson(Map<String, dynamic> json) => Socials(
      instagram: json['instagram'] as String?,
      facebook: json['facebook'] as String?,
      twitter: json['twitter'] as String?,
    );

Map<String, dynamic> _$SocialsToJson(Socials instance) => <String, dynamic>{
      'instagram': instance.instagram,
      'facebook': instance.facebook,
      'twitter': instance.twitter,
    };
