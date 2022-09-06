import 'package:blavapp/model/catering.dart';
import 'package:blavapp/model/contacts.dart';
import 'package:blavapp/model/cosplay.dart';
import 'package:blavapp/model/degustation.dart';
import 'package:blavapp/model/event.dart';
import 'package:blavapp/model/programme.dart';
import 'package:blavapp/model/story.dart';

enum AppHeros { userAvatar }

final Map<AppHeros, String> appHeros = {
  AppHeros.userAvatar: 'appHeroUserAvatar',
};

String eventImgHeroTag(Event event) {
  return 'event-img-title-${event.id}';
}

String programmeEntryImgHeroTag(ProgrammeEntry entry) {
  return 'prog-img-title-${entry.id}';
}

String caterMealItemImgHeroTag(MealItem item) {
  return 'cater-img-item-${item.id}';
}

String caterBeverageItemImgHeroTag(BeverageItem item) {
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

String cosplayImgHeroTag(CosplayRecord record) {
  return 'cosplay-img-item-${record.id}';
}

String contactImgHeroTag(ContactEntity entity) {
  return 'contact-img-item-${entity.id}';
}

String storyFactionImgHeroTag(StoryFaction faction) {
  return 'faction-img-${faction.id}';
}

String storyEntityImgHeroTag(StoryEntity entity) {
  return 'story-entity-img-${entity.id}';
}
