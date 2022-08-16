import 'package:blavapp/bloc/maps/data_maps/maps_bloc.dart';
import 'package:blavapp/components/page_hierarchy/data_error_page.dart';
import 'package:blavapp/components/page_hierarchy/data_loading_page.dart';
import 'package:blavapp/components/page_hierarchy/side_page.dart';
import 'package:blavapp/model/maps.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:blavapp/utils/toasting.dart';
import 'package:blavapp/views/maps/map_custom_interactive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapViewPage extends StatelessWidget {
  final String mapRef;
  final String? pointRefZoom;

  const MapViewPage({
    Key? key,
    required this.mapRef,
    this.pointRefZoom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
            if (state.mapRecords.containsKey(mapRef)) {
              MapRecord mapRecord = state.mapRecords[mapRef]!;
              return SidePage(
                titleText: t(mapRecord.name, context),
                body: CustomMap(
                    screenHeight: height,
                    screenWidth: width,
                    mapRecord: mapRecord,
                    pointRefZoom: pointRefZoom),
              );
            } else {
              return SidePage(
                titleText: 'Map not found',
                body: Center(
                  child: Text('Map $mapRef not found'),
                ),
              );
            }
          case MapsStatus.error:
            return DataErrorPage(message: state.message);
          case MapsStatus.initial:
            return const DataLoadingPage();
        }
      },
    );
  }
}

class MapViewArguments {
  final String mapRef;
  final String? pointRefZoom;

  MapViewArguments({
    required this.mapRef,
    this.pointRefZoom,
  });
}
