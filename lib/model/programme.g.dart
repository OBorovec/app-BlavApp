// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'programme.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Programme _$ProgrammeFromJson(Map<String, dynamic> json) => Programme(
      entries: (json['entries'] as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, ProgEntry.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
      places: (json['places'] as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, ProgPlace.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
      notifications: (json['notifications'] as List<dynamic>?)
              ?.map((e) => ProgNotification.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      extras: (json['extras'] as List<dynamic>?)
              ?.map((e) => Extras.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ProgrammeToJson(Programme instance) => <String, dynamic>{
      'entries': instance.entries,
      'places': instance.places,
      'notifications': instance.notifications,
      'extras': instance.extras,
    };

ProgEntry _$ProgEntryFromJson(Map<String, dynamic> json) => ProgEntry(
      name: Map<String, String>.from(json['name'] as Map),
      subTitle: (json['subTitle'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      type: $enumDecode(_$ProgEntryTypeEnumMap, json['type']),
      entryRuns: (json['entryRuns'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, ProgEntryRun.fromJson(e as Map<String, dynamic>)),
      ),
      lang: $enumDecodeNullable(_$ProgEntryLangEnumMap, json['lang']) ??
          ProgEntryLang.cs,
      placeRef: json['placeRef'] as String?,
      desc: (json['desc'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      acting: (json['acting'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toSet() ??
          const {},
      notifications: (json['notifications'] as List<dynamic>?)
              ?.map((e) => ProgNotification.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ProgEntryToJson(ProgEntry instance) => <String, dynamic>{
      'name': instance.name,
      'subTitle': instance.subTitle,
      'type': _$ProgEntryTypeEnumMap[instance.type]!,
      'entryRuns': instance.entryRuns,
      'lang': _$ProgEntryLangEnumMap[instance.lang]!,
      'placeRef': instance.placeRef,
      'desc': instance.desc,
      'acting': instance.acting,
      'images': instance.images,
      'tags': instance.tags.toList(),
      'notifications': instance.notifications,
    };

const _$ProgEntryTypeEnumMap = {
  ProgEntryType.concert: 'concert',
  ProgEntryType.storyline: 'storyline',
  ProgEntryType.workshop: 'workshop',
  ProgEntryType.lecture: 'lecture',
  ProgEntryType.tournament: 'tournament',
  ProgEntryType.show: 'show',
  ProgEntryType.degustation: 'degustation',
  ProgEntryType.discussion: 'discussion',
  ProgEntryType.gaming: 'gaming',
  ProgEntryType.cosplay: 'cosplay',
  ProgEntryType.other: 'other',
};

const _$ProgEntryLangEnumMap = {
  ProgEntryLang.cs: 'cs',
  ProgEntryLang.en: 'en',
};

ProgEntryRun _$ProgEntryRunFromJson(Map<String, dynamic> json) => ProgEntryRun(
      id: json['id'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      duration: json['duration'] as int,
      lang: $enumDecodeNullable(_$ProgEntryLangEnumMap, json['lang']),
      placeRef: json['placeRef'] as String?,
      acting: (json['acting'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      requireSignUp: json['requireSignUp'] as bool? ?? false,
      price: json['price'] as int?,
      capacity: json['capacity'] as int?,
      occupancy: json['occupancy'] as int?,
      vipOnly: json['vipOnly'] as bool? ?? false,
    );

Map<String, dynamic> _$ProgEntryRunToJson(ProgEntryRun instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timestamp': instance.timestamp.toIso8601String(),
      'duration': instance.duration,
      'lang': _$ProgEntryLangEnumMap[instance.lang],
      'placeRef': instance.placeRef,
      'acting': instance.acting,
      'requireSignUp': instance.requireSignUp,
      'price': instance.price,
      'capacity': instance.capacity,
      'occupancy': instance.occupancy,
      'vipOnly': instance.vipOnly,
    };

ProgPlace _$ProgPlaceFromJson(Map<String, dynamic> json) => ProgPlace(
      name: Map<String, String>.from(json['name'] as Map),
      loc: json['loc'] == null
          ? null
          : ProgPlaceLoc.fromJson(json['loc'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ProgPlaceToJson(ProgPlace instance) => <String, dynamic>{
      'name': instance.name,
      'loc': instance.loc,
      'images': instance.images,
    };

ProgPlaceLoc _$ProgPlaceLocFromJson(Map<String, dynamic> json) => ProgPlaceLoc(
      mapRef: json['mapRef'] as String,
      pointRef: json['pointRef'] as String,
    );

Map<String, dynamic> _$ProgPlaceLocToJson(ProgPlaceLoc instance) =>
    <String, dynamic>{
      'mapRef': instance.mapRef,
      'pointRef': instance.pointRef,
    };

ProgNotification _$ProgNotificationFromJson(Map<String, dynamic> json) =>
    ProgNotification(
      parrentEntry: json['parrentEntry'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
      message: Map<String, String>.from(json['message'] as Map),
    );

Map<String, dynamic> _$ProgNotificationToJson(ProgNotification instance) =>
    <String, dynamic>{
      'parrentEntry': instance.parrentEntry,
      'timestamp': instance.timestamp.toIso8601String(),
      'message': instance.message,
    };
