part of 'story_bloc.dart';

abstract class StoryEvent extends Equatable {
  const StoryEvent();

  @override
  List<Object> get props => [];
}

class StoryStreamChanged extends StoryEvent {
  final Story story;

  const StoryStreamChanged({
    required this.story,
  });
}

class StorySubscriptionFailed extends StoryEvent {
  final String message;

  const StorySubscriptionFailed({required this.message});
}
