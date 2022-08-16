import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'story.g.dart';

@JsonSerializable()
class Story extends Equatable {
  final Map<String, String>? story;
  final List<StoryPart> storyUpdates;
  final Map<String, StoryFaction> factions;

  const Story({
    this.story,
    this.storyUpdates = const [],
    this.factions = const {},
  });

  @override
  List<Object?> get props => [story, storyUpdates, factions];

  factory Story.fromJson(Map<String, Object?> json) => _$StoryFromJson(json);

  Map<String, Object?> toJson() => _$StoryToJson(this);
}

@JsonSerializable()
class StoryPart extends Equatable {
  final Map<String, String> title;
  final Map<String, String> text;
  final String? image;

  const StoryPart({
    this.title = const {},
    this.text = const {},
    this.image,
  });

  @override
  List<Object?> get props => [title, text, image];

  factory StoryPart.fromJson(Map<String, Object?> json) =>
      _$StoryPartFromJson(json);

  Map<String, Object?> toJson() => _$StoryPartToJson(this);
}

@JsonSerializable()
class StoryFaction extends Equatable {
  final String id;
  final Map<String, String> name;
  final String? storyLeaderRef;
  final List<Map<String, Map<String, String>>> highlights;
  final Map<String, String> desc;

  const StoryFaction({
    required this.id,
    this.name = const {},
    this.storyLeaderRef,
    this.highlights = const [],
    this.desc = const {},
  });

  @override
  List<Object?> get props => [id, name, storyLeaderRef, highlights, desc];

  factory StoryFaction.fromJson(Map<String, Object?> json) =>
      _$StoryFactionFromJson(json);

  Map<String, Object?> toJson() => _$StoryFactionToJson(this);
}
