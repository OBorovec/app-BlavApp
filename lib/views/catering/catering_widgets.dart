import 'package:blavapp/constants/icons.dart';
import 'package:blavapp/model/catering.dart';
import 'package:flutter/material.dart';

class CateringAttIcons extends StatelessWidget {
  final CaterItem item;
  final double? size;
  const CateringAttIcons({
    Key? key,
    required this.item,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (item.vegetarian)
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: ImageIcon(
              AppIcons.vegetarian,
              size: size,
            ),
          ),
        if (item.vegan)
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: ImageIcon(
              AppIcons.vegan,
              size: size,
            ),
          ),
        if (item.glutenFree)
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: ImageIcon(
              AppIcons.glutenFree,
              size: size,
            ),
          ),
      ],
    );
  }
}
