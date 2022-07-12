import 'package:blavapp/model/cater_item.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:flutter/material.dart';

class CateringItemCard extends StatelessWidget {
  final CaterItem item;
  final Function() onTap;
  const CateringItemCard({
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
          child: Text(t(item.name, context)),
        ),
      ),
    );
  }
}
