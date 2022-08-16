// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Story _$StoryFromJson(Map<String, dynamic> json) => Story(
      name: (json['name'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      story: (json['story'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      image: json['image'] as String?,
      updates: (json['updates'] as List<dynamic>?)
              ?.map((e) => StoryPart.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      factionGroupName:
          (json['factionGroupName'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      factions: (json['factions'] as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, StoryFaction.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
      entities: (json['entities'] as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, StoryEntity.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
    );

Map<String, dynamic> _$StoryToJson(Story instance) => <String, dynamic>{
      'name': instance.name,
      'story': instance.story,
      'image': instance.image,
      'updates': instance.updates,
      'factionGroupName': instance.factionGroupName,
      'factions': instance.factions,
      'entities': instance.entities,
    };

StoryPart _$StoryPartFromJson(Map<String, dynamic> json) => StoryPart(
      title: (json['title'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      text: (json['text'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      image: json['image'] as String?,
      factionRef: (json['factionRef'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      entityRef: (json['entityRef'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$StoryPartToJson(StoryPart instance) => <String, dynamic>{
      'title': instance.title,
      'text': instance.text,
      'image': instance.image,
      'factionRef': instance.factionRef,
      'entityRef': instance.entityRef,
    };

StoryFaction _$StoryFactionFromJson(Map<String, dynamic> json) => StoryFaction(
      id: json['id'] as String,
      name: (json['name'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      leaderRef: json['leaderRef'] as String?,
      memberRef: (json['memberRef'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      highlights: (json['highlights'] as List<dynamic>?)
              ?.map((e) => (e as Map<String, dynamic>).map(
                    (k, e) => MapEntry(k, Map<String, String>.from(e as Map)),
                  ))
              .toList() ??
          const [],
      desc: (json['desc'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      image: json['image'] as String?,
    );

Map<String, dynamic> _$StoryFactionToJson(StoryFaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'leaderRef': instance.leaderRef,
      'memberRef': instance.memberRef,
      'highlights': instance.highlights,
      'desc': instance.desc,
      'image': instance.image,
    };

StoryEntity _$StoryEntityFromJson(Map<String, dynamic> json) => StoryEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      type: Map<String, String>.from(json['type'] as Map),
      desc: (json['desc'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      contactEntityRef: (json['contactEntityRef'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$StoryEntityToJson(StoryEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'desc': instance.desc,
      'images': instance.images,
      'contactEntityRef': instance.contactEntityRef,
    };
