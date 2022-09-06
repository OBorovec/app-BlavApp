import 'package:blavapp/bloc/story/bloc/story_bloc.dart';
import 'package:blavapp/components/images/app_network_image.dart';
import 'package:blavapp/components/page_content/data_error_page.dart';
import 'package:blavapp/components/page_content/data_loading_page.dart';
import 'package:blavapp/components/pages/page_root.dart';
import 'package:blavapp/components/views/collapsable_text_section.dart';
import 'package:blavapp/components/views/title_divider.dart';
import 'package:blavapp/model/common.dart';
import 'package:blavapp/model/story.dart';
import 'package:blavapp/route_generator.dart';
import 'package:blavapp/utils/app_heros.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:blavapp/views/story/story_faction_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({Key? key}) : super(key: key);

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  // Note: If this becomes more complikaced, consider using a bloc
  bool showFullStoryText = false;
  List<bool> showFullExtrasText = [];
  final ScrollController _mainController = ScrollController();

  void _scrollDown() {
    _mainController.animateTo(
      _mainController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  void _scrollUp() {
    _mainController.animateTo(
      _mainController.position.minScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryBloc, StoryState>(
      builder: (context, state) {
        if (showFullExtrasText.isEmpty) {
          showFullExtrasText = List<bool>.filled(
            state.story.extras.length,
            false,
          );
        }
        switch (state.status) {
          case DataStatus.loaded:
            return Builder(builder: (context) {
              return RootPage(
                titleText: t(state.story.name, context),
                body: SingleChildScrollView(
                  controller: _mainController,
                  child: Column(
                    children: [
                      if (state.story.image != null)
                        _StoryImage(url: state.story.image!),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            if (state.story.story != null)
                              _StoryText(
                                text: state.story.story!,
                                showFull: showFullStoryText,
                                onTap: (() => setState(() {
                                      showFullStoryText = !showFullStoryText;
                                    })),
                              ),
                            ...state.story.extras.map(
                              (Extras e) {
                                int index = state.story.extras.indexOf(e);
                                return CollapsableTextSection(
                                  title: t(e.title, context),
                                  body: t(e.body, context),
                                  isExpanded: showFullExtrasText[index],
                                  onToggle: () => setState(() {
                                    showFullExtrasText[index] =
                                        !showFullExtrasText[index];
                                  }),
                                );
                              },
                            ).toList(),
                            if (state.story.factions.isNotEmpty)
                              _StoryGroupList(state: state),
                            _StoryUpdates(
                              state: state,
                              onEndReached: () => _scrollDown(),
                              onTopReached: () => _scrollUp(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  if (showFullStoryText || showFullExtrasText.contains(true))
                    IconButton(
                      icon: const Icon(Icons.keyboard_arrow_up),
                      onPressed: () {
                        setState(() {
                          showFullStoryText = false;
                          showFullExtrasText = List<bool>.filled(
                            state.story.extras.length,
                            false,
                          );
                        });
                      },
                    ),
                ],
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
  final bool showFull;
  final Function() onTap;

  const _StoryText({
    Key? key,
    required this.text,
    required this.showFull,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          t(text, context),
          maxLines: showFull ? null : 10,
        ),
        InkWell(
          onTap: onTap,
          child: showFull
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(AppLocalizations.of(context)!.genShowLess),
                    const Icon(Icons.keyboard_arrow_up),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(AppLocalizations.of(context)!.genShowMore),
                    const Icon(Icons.keyboard_arrow_down),
                  ],
                ),
        ),
      ],
    );
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

class _StoryUpdates extends StatefulWidget {
  final StoryState state;
  final Function() onEndReached;
  final Function() onTopReached;
  const _StoryUpdates({
    Key? key,
    required this.state,
    required this.onEndReached,
    required this.onTopReached,
  }) : super(key: key);

  @override
  State<_StoryUpdates> createState() => _StoryUpdatesState();
}

class _StoryUpdatesState extends State<_StoryUpdates> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    _controller.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      widget.onEndReached();
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      widget.onTopReached();
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        const SizedBox(height: 16),
        TitleDivider(title: AppLocalizations.of(context)!.contStoryUpdates),
        const SizedBox(height: 8),
        widget.state.updates.isEmpty
            ? Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    child: Text(
                      AppLocalizations.of(context)!.contStoryNoUpdates,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                ),
              )
            : SizedBox(
                height: height * 0.6,
                child: SingleChildScrollView(
                  controller: _controller,
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: widget.state.updates
                        .map(
                          (StoryPart part) => Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    t(part.title, context),
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    children: [
                                      if (part.text != null)
                                        Expanded(
                                          child: Text(
                                            t(part.text!, context),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      if (part.image != null)
                                        Expanded(
                                          child:
                                              AppNetworkImage(url: part.image!),
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
