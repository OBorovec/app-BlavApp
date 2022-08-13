import 'dart:async';
import 'package:blavapp/bloc/app/event_focus/event_focus_bloc.dart';
import 'package:blavapp/model/story.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'story_event.dart';
part 'story_state.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  final DataRepo _dataRepo;
  late final StreamSubscription<EventFocusState> _eventFocusBlocSubscription;
  StreamSubscription<Story>? _storyStream;

  StoryBloc({
    required DataRepo dataRepo,
    required EventFocusBloc eventFocusBloc,
  })  : _dataRepo = dataRepo,
        super(const StoryState(
          status: DataStatus.initial,
          story: Story(),
        )) {
    _eventFocusBlocSubscription = eventFocusBloc.stream.listen(
        (EventFocusState eventFocusState) =>
            createDataStream(eventTag: eventFocusState.eventTag));
    if (eventFocusBloc.state.status == EventFocusStatus.focused) {
      createDataStream(eventTag: eventFocusBloc.state.eventTag);
    }
    // Event listeners
    on<StoryStreamChanged>(_onDataStoryStreamChanged);
    on<StorySubscriptionFailed>(_onDataStorySubscriptionFailed);
  }

  void createDataStream({required String eventTag}) {
    if (_storyStream != null) {
      _storyStream!.cancel();
    }
    _storyStream =
        _dataRepo.getStoryStream(eventTag).listen((Story story) => add(
              StoryStreamChanged(
                story: story,
              ),
            ))
          ..onError(
            (error) {
              if (error is NullDataException) {
                add(StorySubscriptionFailed(message: error.message));
              } else {
                add(StorySubscriptionFailed(message: error.toString()));
              }
            },
          );
  }

  @override
  Future<void> close() {
    _storyStream?.cancel();
    _eventFocusBlocSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _onDataStoryStreamChanged(
    StoryStreamChanged event,
    Emitter<StoryState> emit,
  ) {
    emit(StoryState(
      status: DataStatus.loaded,
      story: event.story,
    ));
  }

  FutureOr<void> _onDataStorySubscriptionFailed(
    StorySubscriptionFailed event,
    Emitter<StoryState> emit,
  ) {
    state.copyWith(
      status: DataStatus.error,
      message: event.message,
    );
  }
}
