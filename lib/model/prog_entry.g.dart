// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prog_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
      placeID: json['placeID'] as String,
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
    );

Map<String, dynamic> _$ProgEntryToJson(ProgEntry instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$ProgEntryTypeEnumMap[instance.type],
      'desc': instance.desc,
      'sDesc': instance.sDesc,
      'placeID': instance.placeID,
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
    };

const _$ProgEntryTypeEnumMap = {
  ProgEntryType.concert: 'concert',
  ProgEntryType.storyline: 'storyline',
  ProgEntryType.workshop: 'workshop',
  ProgEntryType.lecture: 'lecture',
  ProgEntryType.tournament: 'tournament',
  ProgEntryType.other: 'other',
};
