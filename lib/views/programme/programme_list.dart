import 'package:blavapp/bloc/programme/filter_programme/filter_programme_bloc.dart';
import 'package:blavapp/bloc/user_data/user_data/user_data_bloc.dart';
import 'package:blavapp/model/programme.dart';
import 'package:blavapp/route_generator.dart';
import 'package:blavapp/views/programme/programme_details.dart';
import 'package:blavapp/views/programme/programme_list_card.dart';
import 'package:blavapp/views/programme/programme_list_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProgrammeList extends StatelessWidget {
  const ProgrammeList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterProgrammeBloc, FilterProgrammeState>(
      builder: (context, state) {
        return Column(
          children: [
            if (state.searchActive) ...[
              const SizedBox(height: 8),
              const ProgrammeSearchTile(),
              const Divider(),
            ],
            Expanded(
              child: state.programmeEntriesFiltered.isNotEmpty
                  ? ImplicitlyAnimatedList<ProgEntry>(
                      items: state.programmeEntriesFiltered,
                      areItemsTheSame: (a, b) => a.id == b.id,
                      updateDuration: const Duration(milliseconds: 200),
                      insertDuration: const Duration(milliseconds: 200),
                      removeDuration: const Duration(milliseconds: 200),
                      itemBuilder: (context, animation, item, index) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(-1, 0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: Slidable(
                            endActionPane: ActionPane(
                              extentRatio: 2 /
                                  3, // Goes with the current entry card setup
                              motion: const DrawerMotion(),
                              children: _buildSlidableActions(
                                item,
                                context,
                              ),
                            ),
                            child: ProgrammeEntryCard(
                              entry: item,
                              onTap: () => Navigator.pushNamed(
                                context,
                                RoutePaths.programmeEntry,
                                arguments: ProgrammeDetailsArguments(
                                  entry: item,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : state.onlyMyProgramme
                      ? _buildEmptyListMessage(
                          AppLocalizations.of(context)!
                              .contProgrammeListMyEmpty,
                          context,
                        )
                      : _buildEmptyListMessage(
                          AppLocalizations.of(context)!.contProgrammeListEmpty,
                          context,
                        ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEmptyListMessage(String text, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  List<Widget> _buildSlidableActions(
    ProgEntry entry,
    BuildContext context,
  ) {
    return [
      BlocBuilder<UserDataBloc, UserDataState>(
        builder: (context, state) {
          return SlidableAction(
            onPressed: (context) {
              BlocProvider.of<UserDataBloc>(context).add(
                UserDataProgMyNotification(entryId: entry.id),
              );
            },
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
            icon: state.userData.myNotifications.contains(entry.id)
                ? Icons.notifications_active
                : Icons.notification_add,
            label: state.userData.myNotifications.contains(entry.id)
                ? 'Silent'
                : 'Notify',
          );
        },
      ),
      BlocBuilder<UserDataBloc, UserDataState>(
        builder: (context, state) {
          return SlidableAction(
            onPressed: (context) {
              BlocProvider.of<UserDataBloc>(context).add(
                UserDataMyProgramme(entryId: entry.id),
              );
            },
            backgroundColor: Theme.of(context).primaryColor,
            icon: state.userData.myProgramme.contains(entry.id)
                ? Icons.bookmark_added
                : Icons.bookmark_add,
            label: state.userData.myProgramme.contains(entry.id)
                ? 'Remove'
                : 'Add',
          );
        },
      ),
    ];
  }
}
