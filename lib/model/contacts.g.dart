// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contacts _$ContactsFromJson(Map<String, dynamic> json) => Contacts(
      instruction: (json['instruction'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      entities: (json['entities'] as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, ContactEntity.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
      stroyEntities: (json['stroyEntities'] as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, ContactEntity.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
    );

Map<String, dynamic> _$ContactsToJson(Contacts instance) => <String, dynamic>{
      'instruction': instance.instruction,
      'entities': instance.entities,
      'stroyEntities': instance.stroyEntities,
    };

ContactEntity _$ContactEntityFromJson(Map<String, dynamic> json) =>
    ContactEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      type: Map<String, String>.from(json['type'] as Map),
      sDesc: (json['sDesc'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      desc: (json['desc'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      tel: json['tel'] as String?,
      email: json['email'] as String?,
      messenger: json['messenger'] as String?,
      whatsapp: json['whatsapp'] as String?,
      telegram: json['telegram'] as String?,
      viber: json['viber'] as String?,
      instagram: json['instagram'] as String?,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      commonPlaces: (json['commonPlaces'] as List<dynamic>?)
              ?.map((e) => ContactPlace.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      currentPlaceRef: json['currentPlaceRef'] == null
          ? null
          : ContactPlace.fromJson(
              json['currentPlaceRef'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContactEntityToJson(ContactEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'sDesc': instance.sDesc,
      'desc': instance.desc,
      'tel': instance.tel,
      'email': instance.email,
      'messenger': instance.messenger,
      'whatsapp': instance.whatsapp,
      'telegram': instance.telegram,
      'viber': instance.viber,
      'instagram': instance.instagram,
      'images': instance.images,
      'commonPlaces': instance.commonPlaces,
      'currentPlaceRef': instance.currentPlaceRef,
    };

ContactPlace _$ContactPlaceFromJson(Map<String, dynamic> json) => ContactPlace(
      map: json['map'] as String,
      placeRef: json['placeRef'] as String,
    );

Map<String, dynamic> _$ContactPlaceToJson(ContactPlace instance) =>
    <String, dynamic>{
      'map': instance.map,
      'placeRef': instance.placeRef,
    };
