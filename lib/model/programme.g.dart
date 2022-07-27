// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'programme.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Programme _$ProgrammeFromJson(Map<String, dynamic> json) => Programme(
      entries: (json['entries'] as List<dynamic>)
          .map((e) => ProgEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      notifications: (json['notifications'] as List<dynamic>?)
              ?.map((e) => ProgNotification.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ProgrammeToJson(Programme instance) => <String, dynamic>{
      'entries': instance.entries,
      'notifications': instance.notifications,
    };

ProgEntry _$ProgEntryFromJson(Map<String, dynamic> json) => ProgEntry(
      id: json['id'] as String,
      name: Map<String, String>.from(json['name'] as Map),
      type: $enumDecode(_$ProgEntryTypeEnumMap, json['type']),
      desc: (json['desc'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      sDesc: (json['sDesc'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      placeRef: json['placeRef'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
      duration: json['duration'] as int,
      allDayEntry: json['allDayEntry'] as bool? ?? false,
      price: json['price'] as int?,
      performing: json['performing'] as String?,
      organizer: json['organizer'] as String?,
      sponsor: (json['sponsor'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      contactPageID: json['contactPageID'] as String?,
      capacity: json['capacity'] as int?,
      occupancy: json['occupancy'] as int?,
      vipOnly: json['vipOnly'] as bool? ?? false,
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
      'id': instance.id,
      'name': instance.name,
      'type': _$ProgEntryTypeEnumMap[instance.type],
      'desc': instance.desc,
      'sDesc': instance.sDesc,
      'placeRef': instance.placeRef,
      'timestamp': instance.timestamp.toIso8601String(),
      'duration': instance.duration,
      'allDayEntry': instance.allDayEntry,
      'price': instance.price,
      'performing': instance.performing,
      'organizer': instance.organizer,
      'sponsor': instance.sponsor,
      'contactPageID': instance.contactPageID,
      'capacity': instance.capacity,
      'occupancy': instance.occupancy,
      'vipOnly': instance.vipOnly,
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
  ProgEntryType.photo: 'photo',
  ProgEntryType.cosplay: 'cosplay',
  ProgEntryType.other: 'other',
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
