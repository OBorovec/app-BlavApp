import 'package:blavapp/model/degus_item.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:flutter/material.dart';

class DegustationItemCard extends StatelessWidget {
  final DegusItem item;
  final Function() onTap;
  const DegustationItemCard({
    Key? key,
    required this.item,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: IntrinsicHeight(
          child: Text(t(item.name!, context)),
        ),
      ),
    );
  }
}
