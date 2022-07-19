import 'package:blavapp/model/cater_item.dart';
import 'package:blavapp/model/prog_entry.dart';

enum AppHeros { userAvatar }

final Map<AppHeros, String> appHeros = {
  AppHeros.userAvatar: 'appHeroUserAvatar',
};

String programmeEntryImgHeroTag(ProgEntry entry) {
  return 'prog-img-title-${entry.id}';
}

String caterItemImgHeroTag(CaterItem item) {
  return 'cater-img-title-${item.id}';
}
