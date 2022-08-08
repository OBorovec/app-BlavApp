import 'package:blavapp/route_generator.dart';
import 'package:blavapp/views/maps/map_view_page.dart';
import 'package:flutter/material.dart';

class IconBtnPushCustomMap extends StatelessWidget {
  final String mapRef;
  final String pointRef;
  const IconBtnPushCustomMap({
    Key? key,
    required this.mapRef,
    required this.pointRef,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.location_on),
      onPressed: () => Navigator.pushNamed(
        context,
        RoutePaths.mapView,
        arguments: MapViewArguments(
          mapRef: mapRef,
          pointRefZoom: pointRef,
        ),
      ),
    );
  }
}
