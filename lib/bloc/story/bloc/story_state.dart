part of 'story_bloc.dart';

enum DataStatus {
  initial,
  loaded,
  error,
}

class StoryState extends Equatable {
  final DataStatus status;
  final String message;
  final Story story;
  const StoryState({
    required this.status,
    this.message = '',
    required this.story,
  });

  List<StoryPart> get updates => story.updates;
  Map<String, StoryFaction> get factions => story.factions;
  Map<String, StoryEntity> get entities => story.entities;

  @override
  List<Object> get props => [status, message, story];

  StoryState copyWith({
    DataStatus? status,
    String? message,
    Story? story,
  }) {
    return StoryState(
      status: status ?? this.status,
      message: message ?? this.message,
      story: story ?? this.story,
    );
  }
}
