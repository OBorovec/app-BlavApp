import 'package:blavapp/bloc/catering/data_catering/catering_bloc.dart';
import 'package:blavapp/bloc/user_data/user_local_prefs/user_local_prefs_bloc.dart';
import 'package:blavapp/components/images/app_network_image.dart';
import 'package:blavapp/model/catering.dart';
import 'package:blavapp/utils/app_heros.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:blavapp/utils/pref_interpreter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// TODO: make this structure more readable

class BeverageItemCard extends StatelessWidget {
  final BeverageItem item;
  const BeverageItemCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, CaterPlace> places =
        BlocProvider.of<CateringBloc>(context).state.cateringPlaces;
    return Card(
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t(item.name, context),
                          style: Theme.of(context).textTheme.headline6,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        _buildInfoLine(
                          Icons.category_outlined,
                          tBeverageItemType(item.type, context),
                        ),
                        _buildInfoLine(
                          item.alcoholic
                              ? Icons.local_bar
                              : Icons.local_bar_outlined,
                          item.alcoholic
                              ? AppLocalizations.of(context)!
                                  .modelCateringBeverageAlcoholic
                              : AppLocalizations.of(context)!
                                  .modelCateringBeverageNonAlcoholic,
                        ),
                        _buildInfoLine(
                          Icons.coffee,
                          item.alcoholic
                              ? AppLocalizations.of(context)!
                                  .modelCateringBeverageHot
                              : AppLocalizations.of(context)!
                                  .modelCateringBeverageCold,
                        ),
                        if (item.placeRef.isNotEmpty) ...[
                          const Divider(),
                          for (String placeRef in item.placeRef)
                            _buildInfoLine(
                              Icons.place_outlined,
                              places.containsKey(placeRef)
                                  ? t(places[placeRef]!.name, context)
                                  : '?$placeRef?',
                            ),
                        ],
                        const Divider(),
                        if (item.desc != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            t(item.desc!, context),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                if (item.images.isNotEmpty)
                  Expanded(
                    flex: 1,
                    child: _CateringItemHeroImage(item: item),
                  ),
              ],
            ),
          ),
          const Divider(),
          _CaterPriceWrap(item: item),
        ],
      ),
    );
  }

  Widget _buildInfoLine(IconData iconData, String text) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Icon(
            iconData,
            size: 14,
          ),
          const VerticalDivider(),
          Expanded(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _CateringItemHeroImage extends StatelessWidget {
  const _CateringItemHeroImage({
    Key? key,
    required this.item,
  }) : super(key: key);

  final BeverageItem item;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: caterBeverageItemImgHeroTag(item),
      child: AppNetworkImage(
        url: item.images[0],
        asCover: true,
      ),
    );
  }
}

class _CaterPriceWrap extends StatelessWidget {
  const _CaterPriceWrap({
    Key? key,
    required this.item,
  }) : super(key: key);

  final BeverageItem item;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.end,
      children: item.volumes
          .map((CaterVolume e) => _CaterPriceVolume(pv: e))
          .toList(),
    );
  }
}

class _CaterPriceVolume extends StatelessWidget {
  final CaterVolume pv;
  const _CaterPriceVolume({
    Key? key,
    required this.pv,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          BlocBuilder<UserLocalPrefsBloc, UserLocalPrefsState>(
            builder: (context, state) {
              return Text(
                prefCurrency(state.currency, pv.price, context),
                style: Theme.of(context).textTheme.headline6,
              );
            },
          ),
          if (pv.desc != null) Text(t(pv.desc!, context)),
        ],
      ),
    );
  }
}
