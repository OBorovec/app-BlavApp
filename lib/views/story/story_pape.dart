import 'package:blavapp/bloc/story/bloc/story_bloc.dart';
import 'package:blavapp/components/images/app_network_image.dart';
import 'package:blavapp/components/page_hierarchy/data_error_page.dart';
import 'package:blavapp/components/page_hierarchy/data_loading_page.dart';
import 'package:blavapp/components/page_hierarchy/root_page.dart';
import 'package:blavapp/components/views/title_divider.dart';
import 'package:blavapp/model/story.dart';
import 'package:blavapp/route_generator.dart';
import 'package:blavapp/utils/app_heros.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:blavapp/utils/toasting.dart';
import 'package:blavapp/views/story/story_faction_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StoryPage extends StatelessWidget {
  const StoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoryBloc, StoryState>(
      listenWhen: (previous, current) => previous.message != current.message,
      listener: (context, state) {
        if (state.status == DataStatus.error) {
          Toasting.notifyToast(context, state.message);
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case DataStatus.loaded:
            return Builder(builder: (context) {
              return RootPage(
                titleText: t(state.story.name, context),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (state.story.image != null)
                        _StoryImage(url: state.story.image!),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            if (state.story.story != null)
                              _StoryText(text: state.story.story!),
                            _StoryGroupList(state: state),
                            _StoryUpdates(state: state),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
          case DataStatus.error:
            return DataErrorPage(message: state.message);
          case DataStatus.initial:
            return const DataLoadingPage();
        }
      },
    );
  }
}

class _StoryImage extends StatelessWidget {
  final String url;

  const _StoryImage({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.4,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(64),
        ),
        child: AppNetworkImage(
          url: url,
          asCover: true,
        ),
      ),
    );
  }
}

class _StoryText extends StatelessWidget {
  final Map<String, String> text;

  const _StoryText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(t(text, context));
  }
}

class _StoryGroupList extends StatelessWidget {
  final StoryState state;
  const _StoryGroupList({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        TitleDivider(title: AppLocalizations.of(context)!.contStoryGroups),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: state.factions.entries.map((e) {
              return InkWell(
                onTap: () => Navigator.pushNamed(
                    context, RoutePaths.storyFaction,
                    arguments: StoryFactionDetailsArguments(factionRef: e.key)),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 96,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 64,
                            child: e.value.image != null
                                ? Hero(
                                    tag: storyFactionImgHeroTag(e.value),
                                    child: AppNetworkImage(
                                      url: e.value.image!,
                                    ),
                                  )
                                : null,
                          ),
                          Text(
                            t(e.value.name, context),
                            style: Theme.of(context).textTheme.subtitle2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}

class _StoryUpdates extends StatelessWidget {
  final StoryState state;
  const _StoryUpdates({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        const SizedBox(height: 16),
        TitleDivider(title: AppLocalizations.of(context)!.contStoryUpdates),
        SizedBox(
          height: height * 0.6,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: state.updates
                  .map(
                    (StoryPart part) => Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              t(part.title, context),
                              style: Theme.of(context).textTheme.headline6,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    t(part.text, context),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (part.image != null)
                                  Expanded(
                                    child: AppNetworkImage(url: part.image!),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
