import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'story.g.dart';

@JsonSerializable()
class Story extends Equatable {
  final Map<String, String> name;
  final Map<String, String>? story;
  final String? image;
  final List<StoryPart> updates;
  final Map<String, String>? factionGroupName;
  final Map<String, StoryFaction> factions;
  final Map<String, StoryEntity> entities;

  const Story({
    required this.name,
    this.story,
    this.image,
    this.updates = const [],
    this.factionGroupName,
    this.factions = const {},
    this.entities = const {},
  });

  @override
  List<Object?> get props => [
        name,
        story,
        image,
        updates,
        factionGroupName,
        factions,
        entities,
      ];

  factory Story.fromJson(Map<String, Object?> json) => _$StoryFromJson(json);

  Map<String, Object?> toJson() => _$StoryToJson(this);
}

@JsonSerializable()
class StoryPart extends Equatable {
  final Map<String, String> title;
  final Map<String, String>? text;
  final String? image;
  final List<String> factionRef;
  final List<String> entityRef;

  const StoryPart({
    required this.title,
    this.text,
    this.image,
    this.factionRef = const [],
    this.entityRef = const [],
  });

  @override
  List<Object?> get props => [title, text, image, factionRef, entityRef];

  factory StoryPart.fromJson(Map<String, Object?> json) =>
      _$StoryPartFromJson(json);

  Map<String, Object?> toJson() => _$StoryPartToJson(this);
}

enum HighligthType { shout, leader }

@JsonSerializable()
class StoryFaction extends Equatable {
  final String id;
  final Map<String, String> name;
  final String? leaderRef;
  final List<String> memberRef;
  final List<Map<String, Map<String, String>>> highlights;
  final Map<String, String> desc;
  final String? image;

  const StoryFaction({
    required this.id,
    required this.name,
    this.leaderRef,
    this.memberRef = const [],
    this.highlights = const [],
    this.desc = const {},
    this.image,
  });

  @override
  List<Object?> get props =>
      [id, name, leaderRef, memberRef, highlights, desc, image];

  factory StoryFaction.fromJson(Map<String, Object?> json) =>
      _$StoryFactionFromJson(json);

  Map<String, Object?> toJson() => _$StoryFactionToJson(this);
}

@JsonSerializable()
class StoryEntity extends Equatable {
  final String id;
  final String name;
  final Map<String, String>? type;
  final Map<String, String>? desc;
  final List<String> images;
  final List<String> contactEntityRef;

  const StoryEntity({
    required this.id,
    required this.name,
    this.type,
    this.desc,
    this.images = const [],
    this.contactEntityRef = const [],
  });

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        desc,
        images,
        contactEntityRef,
      ];

  factory StoryEntity.fromJson(Map<String, Object?> json) =>
      _$StoryEntityFromJson(json);

  Map<String, Object?> toJson() => _$StoryEntityToJson(this);
}
