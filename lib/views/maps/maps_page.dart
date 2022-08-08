import 'package:blavapp/bloc/maps/data_maps/maps_bloc.dart';
import 'package:blavapp/components/page_hierarchy/root_page.dart';
import 'package:blavapp/components/bloc_pages/bloc_error_page.dart';
import 'package:blavapp/components/bloc_pages/bloc_loading_page.dart';
import 'package:blavapp/model/maps.dart';
import 'package:blavapp/route_generator.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:blavapp/utils/toasting.dart';
import 'package:blavapp/views/maps/map_view_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  int navigationIndex = 0;
  final cateringPages = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapsBloc, MapsState>(
      listenWhen: (previous, current) => previous.message != current.message,
      listener: (context, state) {
        if (state.status == MapsStatus.error) {
          Toasting.notifyToast(context, state.message);
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case MapsStatus.loaded:
            return RootPage(
              titleText: AppLocalizations.of(context)!.mapsTitle,
              body: _MapsMainContent(state: state),
            );
          case MapsStatus.error:
            return BlocErrorPage(message: state.message);
          case MapsStatus.initial:
            return const BlocLoadingPage();
        }
      },
    );
  }
}

class _MapsMainContent extends StatelessWidget {
  final MapsState state;
  const _MapsMainContent({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomScrollView(
                slivers: [
                  SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    delegate: SliverChildListDelegate(
                      state.mapRecords.entries
                          .map(
                            (entry) => _MapRecordCard(
                              mapRecord: entry.value,
                              onTap: () => Navigator.pushNamed(
                                context,
                                RoutePaths.mapView,
                                arguments: MapViewArguments(
                                  mapRef: entry.key,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
          Text(
            AppLocalizations.of(context)!.mapsReadlWorldHeader,
            style: Theme.of(context).textTheme.headline5,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          ...state.realWorldRecords.map((e) => _RealWorldRecordCard(
                realWorldRecord: e,
                onTap: () {},
              )),
        ],
      ),
    );
  }
}

class _MapRecordCard extends StatelessWidget {
  final MapRecord mapRecord;
  final Function() onTap;
  const _MapRecordCard({
    Key? key,
    required this.mapRecord,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 150,
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  mapRecord.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    t(mapRecord.name, context),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RealWorldRecordCard extends StatelessWidget {
  final RealWorldRecord realWorldRecord;
  final Function() onTap;
  const _RealWorldRecordCard({
    Key? key,
    required this.realWorldRecord,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                // TODO: open GPS location using map app
              },
              icon: const Icon(Icons.location_on),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t(realWorldRecord.name, context),
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                if (realWorldRecord.desc != null)
                  Text(
                    t(realWorldRecord.desc!, context),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}