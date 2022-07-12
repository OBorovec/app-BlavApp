import 'package:blavapp/bloc/data_degustation/degustation_bloc.dart';
import 'package:blavapp/route_generator.dart';
import 'package:blavapp/utils/toasting.dart';
import 'package:blavapp/views/catering/degustation_details.dart';
import 'package:blavapp/views/catering/degustation_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DegustationList extends StatelessWidget {
  const DegustationList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DegustationBloc, DegustationState>(
      listener: (context, state) {
        if (state is DegustationFailState) {
          Toasting.notifyToast(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is DegustationLoaded) {
          return ListView.builder(
            itemCount: state.degustationItems.length,
            itemBuilder: (context, index) {
              return DegustationItemCard(
                item: state.degustationItems[index],
                onTap: () => Navigator.pushNamed(
                  context,
                  RoutePaths.degustationItem,
                  arguments: DegustationDetailsArguments(
                    item: state.degustationItems[index],
                  ),
                ),
              );
            },
          );
        } else if (state is DegustationFailState) {
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
