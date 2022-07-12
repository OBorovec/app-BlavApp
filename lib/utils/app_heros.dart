import 'package:blavapp/model/prog_entry.dart';

enum AppHeros { userAvatar }

final Map<AppHeros, String> appHeros = {
  AppHeros.userAvatar: 'appHeroUserAvatar',
};

String programmeEntryImgHeroTag(ProgEntry entry) {
  return 'img-title-${entry.id}';
}

String programmeEntryTitleHeroTag(ProgEntry entry) {
  return 'prg-title-${entry.id}';
}

String programmeEntryDateHeroTag(ProgEntry entry) {
  return 'date-title-${entry.id}';
}

String programmeEntryPlaceHeroTag(ProgEntry entry) {
  return 'place-title-${entry.id}';
}

String programmeEntryDescHeroTag(ProgEntry entry) {
  return 'desc-title-${entry.id}';
}
