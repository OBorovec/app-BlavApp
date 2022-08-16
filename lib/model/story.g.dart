// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Story _$StoryFromJson(Map<String, dynamic> json) => Story(
      story: (json['story'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      storyUpdates: (json['storyUpdates'] as List<dynamic>?)
              ?.map((e) => StoryPart.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      factions: (json['factions'] as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, StoryFaction.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
    );

Map<String, dynamic> _$StoryToJson(Story instance) => <String, dynamic>{
      'story': instance.story,
      'storyUpdates': instance.storyUpdates,
      'factions': instance.factions,
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
    );

Map<String, dynamic> _$StoryPartToJson(StoryPart instance) => <String, dynamic>{
      'title': instance.title,
      'text': instance.text,
      'image': instance.image,
    };

StoryFaction _$StoryFactionFromJson(Map<String, dynamic> json) => StoryFaction(
      id: json['id'] as String,
      name: (json['name'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      storyLeaderRef: json['storyLeaderRef'] as String?,
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
    );

Map<String, dynamic> _$StoryFactionToJson(StoryFaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'storyLeaderRef': instance.storyLeaderRef,
      'highlights': instance.highlights,
      'desc': instance.desc,
    };
