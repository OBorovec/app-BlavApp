import 'package:blavapp/bloc/degustation/filter_degustation/filter_degustation_bloc.dart';
import 'package:blavapp/model/degustation.dart';
import 'package:blavapp/route_generator.dart';
import 'package:blavapp/views/degustation/degustation_details.dart';
import 'package:blavapp/views/degustation/degustation_list_card.dart';
import 'package:blavapp/views/degustation/degustation_list_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DegustationList extends StatelessWidget {
  const DegustationList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterDegustationBloc, FilterDegustationState>(
      builder: (context, state) {
        return Column(
          children: [
            if (state.searchActive) ...[
              const SizedBox(height: 8),
              const DegustationSearchTile(),
              const Divider(),
            ],
            Expanded(
              child: state.degusItemsFiltered.isNotEmpty
                  ? ImplicitlyAnimatedList<DegusItem>(
                      items: state.degusItemsFiltered,
                      padding: const EdgeInsets.only(bottom: 64.0),
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
                          child: DegustationItemCard(
                            item: item,
                            onTap: () => Navigator.pushNamed(
                              context,
                              RoutePaths.degustationItem,
                              arguments: DegustationDetailsArguments(
                                item: item,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  // Empty list
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppLocalizations.of(context)!
                              .contDegustationListFavoriteEmpty,
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }
}
