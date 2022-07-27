import 'package:blavapp/components/_pages/side_page.dart';
import 'package:blavapp/model/degustation.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:flutter/material.dart';

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
      body: const Center(
        child: Text('Laborum dolorem dignissimos molestias.'),
      ),
    );
  }
}

class DegustationDetailsArguments {
  final DegusItem item;

  DegustationDetailsArguments({required this.item});
}
