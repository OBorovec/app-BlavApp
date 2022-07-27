import 'package:blavapp/model/catering.dart';
import 'package:blavapp/model/degustation.dart';
import 'package:blavapp/model/programme.dart';

enum AppHeros { userAvatar }

final Map<AppHeros, String> appHeros = {
  AppHeros.userAvatar: 'appHeroUserAvatar',
};

String programmeEntryImgHeroTag(ProgEntry entry) {
  return 'prog-img-title-${entry.id}';
}

String caterItemImgHeroTag(CaterItem item) {
  return 'cater-img-item-${item.id}';
}

String caterItemPlaceHeroTag(CaterPlace place) {
  return 'cater-img-place-${place.hashCode}';
}

String degusItemImgHeroTag(DegusItem item) {
  return 'degus-img-item-${item.id}';
}

String degusItemPlaceHeroTag(DegusPlace place) {
  return 'degus-img-place-${place.hashCode}';
}
