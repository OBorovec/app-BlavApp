import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'story.g.dart';

@JsonSerializable()
class Story extends Equatable {
  final List<StoryPart> storyParts;

  const Story({
    this.storyParts = const [],
  });

  @override
  List<Object?> get props => [];

  factory Story.fromJson(Map<String, Object?> json) => _$StoryFromJson(json);

  Map<String, Object?> toJson() => _$StoryToJson(this);
}

@JsonSerializable()
class StoryPart extends Equatable {
  final Map<String, String> title;
  final Map<String, String> text;

  const StoryPart({
    this.title = const {},
    this.text = const {},
  });

  @override
  List<Object?> get props => [];

  factory StoryPart.fromJson(Map<String, Object?> json) =>
      _$StoryPartFromJson(json);

  Map<String, Object?> toJson() => _$StoryPartToJson(this);
}
