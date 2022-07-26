import 'package:blavapp/model/maps.dart';
import 'package:flutter/material.dart';

IconData mapPointTypeIcon(MapPointType type) {
  switch (type) {
    case MapPointType.catering:
      return Icons.fastfood;
    case MapPointType.degustation:
      return Icons.local_bar;
    case MapPointType.programme:
      return Icons.event;
    case MapPointType.shop:
      return Icons.store;
    case MapPointType.wc:
      return Icons.wc;
    case MapPointType.other:
      return Icons.location_on;
  }
}
