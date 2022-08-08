import 'package:blavapp/components/page_hierarchy/side_page.dart';
import 'package:blavapp/model/degustation.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:flutter/material.dart';

class DegustationPlaceDetails extends StatelessWidget {
  final DegusPlace place;
  const DegustationPlaceDetails({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SidePage(
      titleText: t(place.name, context),
      body: const Center(
        child: Text('Laborum dolorem dignissimos molestias.'),
      ),
    );
  }
}

class DegustationPlaceDetailsArguments {
  final DegusPlace place;

  DegustationPlaceDetailsArguments({required this.place});
}
