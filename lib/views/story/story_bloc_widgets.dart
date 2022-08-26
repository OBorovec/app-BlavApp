import 'package:blavapp/bloc/story/bloc/story_bloc.dart';
import 'package:blavapp/model/story.dart';
import 'package:blavapp/utils/app_heros.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoryEntityAvatar extends StatelessWidget {
  final String entityRef;
  const StoryEntityAvatar({
    Key? key,
    required this.entityRef,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryBloc, StoryState>(
      builder: (context, state) {
        final StoryEntity? entity = state.entities[entityRef];
        return InkWell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 124,
              height: 114,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: entity != null
                        ? Hero(
                            tag: storyEntityImgHeroTag(entity),
                            child: CircleAvatar(
                              radius: 57,
                              backgroundImage: NetworkImage(
                                entity.images[0],
                              ),
                            ),
                          )
                        : const Icon(
                            Icons.question_mark,
                            size: 57 * 2,
                          ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Card(
                      child: Column(
                        children: [
                          Text(
                            entity != null ? entity.name : entityRef,
                            style: Theme.of(context).textTheme.titleSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                          if (entity != null && entity.type != null)
                            Text(
                              t(entity.type!, context),
                              style: Theme.of(context).textTheme.bodySmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
