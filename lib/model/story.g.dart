// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Story _$StoryFromJson(Map<String, dynamic> json) => Story(
      storyParts: (json['storyParts'] as List<dynamic>?)
              ?.map((e) => StoryPart.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$StoryToJson(Story instance) => <String, dynamic>{
      'storyParts': instance.storyParts,
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
    );

Map<String, dynamic> _$StoryPartToJson(StoryPart instance) => <String, dynamic>{
      'title': instance.title,
      'text': instance.text,
    };
