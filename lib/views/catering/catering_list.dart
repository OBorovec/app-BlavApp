import 'package:blavapp/bloc/data_catering/catering_bloc.dart';
import 'package:blavapp/utils/toasting.dart';
import 'package:blavapp/views/catering/catering_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CateringList extends StatelessWidget {
  const CateringList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CateringBloc, CateringState>(
      listener: (context, state) {
        if (state is CateringFailState) {
          Toasting.notifyToast(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is CateringLoaded) {
          return ListView.builder(
            itemCount: state.cateringItems.length,
            itemBuilder: (context, index) {
              return CateringItemCard(
                item: state.cateringItems[index],
                onTap: () => {},
              );
            },
          );
        } else if (state is CateringFailState) {
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
