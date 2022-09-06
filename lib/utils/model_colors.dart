import 'package:blavapp/model/programme.dart';
import 'package:flutter/material.dart';

Color colorProgEntryType(ProgEntryType type, BuildContext context) {
  switch (type) {
    case ProgEntryType.concert:
      return Colors.red.shade400;
    case ProgEntryType.storyline:
      return Colors.blue.shade400;
    case ProgEntryType.workshop:
      return Colors.green.shade400;
    case ProgEntryType.lecture:
      return Colors.pink.shade400;
    case ProgEntryType.tournament:
      return Colors.purple.shade400;
    case ProgEntryType.show:
      return Colors.cyan.shade400;
    case ProgEntryType.degustation:
      return Colors.amber.shade400;
    case ProgEntryType.discussion:
      return Colors.yellow.shade400;
    case ProgEntryType.gaming:
      return Colors.greenAccent.shade400;
    case ProgEntryType.cosplay:
      return Colors.blueAccent.shade400;
    case ProgEntryType.other:
      return Colors.blueGrey.shade400;
    default:
      return Colors.grey.shade400;
  }
}
