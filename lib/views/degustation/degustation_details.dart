import 'package:blavapp/bloc/user_data/user_data/user_data_bloc.dart';
import 'package:blavapp/components/control/rating_bar.dart';
import 'package:blavapp/components/page_hierarchy/side_page.dart';
import 'package:blavapp/components/views/rating_indicator.dart';
import 'package:blavapp/model/degustation.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DegustationDetails extends StatelessWidget {
  final DegusItem item;
  const DegustationDetails({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SidePage(
        titleText: t(item.name, context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [_DegustationItemRating(item: item)],
            ),
          ),
        ));
  }
}

class _DegustationItemRating extends StatelessWidget {
  final DegusItem item;

  const _DegustationItemRating({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: Divider()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                AppLocalizations.of(context)!.degusDetailRating,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            const Expanded(child: Divider()),
          ],
        ),
        IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: item.rating != null
                      ? AppRatingIndicator(
                          rating: item.rating!,
                          itemSize: 32,
                        )
                      : Text(
                          AppLocalizations.of(context)!.degusDetailNoRating,
                          style: Theme.of(context).textTheme.subtitle1,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                ),
              ),
              if (item.rating != null)
                Text(
                  '(${item.rating})',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              const VerticalDivider(),
              BlocBuilder<UserDataBloc, UserDataState>(
                builder: (context, state) {
                  if (state.usedData.myRatings.containsKey(item.id)) {
                    return InkWell(
                      onLongPress: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => _buildRatingDialog(
                            context,
                            AppLocalizations.of(context)!
                                .degusDetailReRateMeTitle),
                      ),
                      child: Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.degusDetailYourRating,
                            style: Theme.of(context).textTheme.subtitle2,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            state.usedData.myRatings[item.id].toString(),
                            style: Theme.of(context).textTheme.subtitle1,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  } else {
                    return ElevatedButton(
                      onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => _buildRatingDialog(
                            context,
                            AppLocalizations.of(context)!
                                .degusDetailRateMeTitle),
                      ),
                      child: Text(
                          AppLocalizations.of(context)!.degusDetailBtnRateMe),
                    );
                  }
                },
              ),
            ],
          ),
        )
      ],
    );
  }

  AlertDialog _buildRatingDialog(BuildContext context, String titleText) {
    return AlertDialog(
      title: Text(
        titleText,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AppRatingBar(
            onRating: ((rating) {
              BlocProvider.of<UserDataBloc>(context).add(
                UserDataRateItem(
                  itemRef: item.id,
                  rating: rating,
                ),
              );
              Navigator.pop(context);
            }),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppLocalizations.of(context)!.dismiss),
        ),
      ],
    );
  }
}

class DegustationDetailsArguments {
  final DegusItem item;

  DegustationDetailsArguments({required this.item});
}
