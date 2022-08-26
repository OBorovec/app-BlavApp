import 'package:blavapp/components/pages/page_side.dart';
import 'package:blavapp/model/catering.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:flutter/material.dart';

class CateringDetails extends StatelessWidget {
  final CaterItem item;
  const CateringDetails({
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

class CateringDetailsArguments {
  final CaterItem item;

  CateringDetailsArguments({required this.item});
}
