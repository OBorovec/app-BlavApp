import 'package:blavapp/bloc/data_catering/catering_bloc.dart';
import 'package:blavapp/bloc/filter_catering/filter_catering_bloc.dart';
import 'package:blavapp/model/cater_item.dart';
import 'package:blavapp/route_generator.dart';
import 'package:blavapp/utils/toasting.dart';
import 'package:blavapp/views/catering/catering_details.dart';
import 'package:blavapp/views/catering/catering_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';

class CateringList extends StatelessWidget {
  const CateringList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('building: catering list');
    return BlocConsumer<CateringBloc, CateringState>(
      listenWhen: (previous, current) => previous.message != current.message,
      listener: (context, state) {
        if (state.status == CateringStatus.failed) {
          Toasting.notifyToast(context, state.message);
        }
      },
      builder: (context, state) {
        print('building: programme consumer');
        if (state.status == CateringStatus.loaded) {
          return BlocProvider(
            create: (context) => FilterCateringBloc(
              cateringBloc: context.read<CateringBloc>(),
            ),
            child: BlocBuilder<FilterCateringBloc, FilterCateringState>(
              builder: (context, state) {
                print('building: inner list');
                return ImplicitlyAnimatedList<CaterItem>(
                  items: state.cateringItemsFiltered,
                  areItemsTheSame: (a, b) => a.id == b.id,
                  updateDuration: const Duration(milliseconds: 200),
                  insertDuration: const Duration(milliseconds: 200),
                  removeDuration: const Duration(milliseconds: 200),
                  itemBuilder: (context, animation, item, index) {
                    return CateringItemCard(
                      item: item,
                      onTap: () => Navigator.pushNamed(
                        context,
                        RoutePaths.cateringItem,
                        arguments: CateringDetailsArguments(
                          item: item,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        } else if (state.status == CateringStatus.failed) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.error),
                Text(AppLocalizations.of(context)!.blocDataFail(state.message)),
              ],
            ),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const CircularProgressIndicator(),
                Text(AppLocalizations.of(context)!.blocDataLoading),
              ],
            ),
          );
        }
      },
    );
  }
}
