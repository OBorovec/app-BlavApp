import 'package:blavapp/bloc/catering/filter_catering/filter_catering_bloc.dart';
import 'package:blavapp/model/catering.dart';
import 'package:blavapp/route_generator.dart';
import 'package:blavapp/views/catering/catering_details.dart';
import 'package:blavapp/views/catering/catering_list_card.dart';
import 'package:blavapp/views/catering/catering_list_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';

class CateringList extends StatelessWidget {
  const CateringList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCateringBloc, FilterCateringState>(
      builder: (context, state) {
        return Column(
          children: [
            if (state.searchActive) ...[
              const SizedBox(height: 8),
              const CateringSearchTile(),
              const Divider(),
            ],
            Expanded(
              child: ImplicitlyAnimatedList<CaterItem>(
                items: state.cateringItemsFiltered,
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
                    child: CateringItemCard(
                      item: item,
                      onTap: () => Navigator.pushNamed(
                        context,
                        RoutePaths.cateringItem,
                        arguments: CateringDetailsArguments(
                          item: item,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
