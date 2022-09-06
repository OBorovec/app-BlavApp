import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:blavapp/model/common.dart';

part 'programme.g.dart';

// Final structure to be used in the app
class ProgrammeEntry extends Equatable {
  final String id;
  final DateTime timestamp;
  final int duration;
  final Map<String, String> name;
  final Map<String, String>? subTitle;
  final Map<String, String>? desc;
  final ProgEntryType type;
  final ProgEntryLang lang;
  final String? placeRef;
  final Map<String, String>? acting;
  final bool requireSignUp;
  final int? price;
  final int? capacity;
  final int? occupancy;
  final bool vipOnly;
  final List<String> images;
  final Set<String> tags;
  final List<ProgNotification> notifications;

  const ProgrammeEntry({
    required this.id,
    required this.timestamp,
    required this.duration,
    required this.name,
    this.subTitle,
    this.desc,
    required this.type,
    this.lang = ProgEntryLang.cs,
    this.placeRef,
    this.acting,
    this.requireSignUp = false,
    this.price,
    this.capacity,
    this.occupancy,
    this.vipOnly = false,
    this.images = const [],
    this.tags = const {},
    this.notifications = const [],
  });

  @override
  List<Object?> get props => [
        id,
        timestamp,
        duration,
        name,
        subTitle,
        desc,
        type,
        lang,
        placeRef,
        acting,
        requireSignUp,
        price,
        capacity,
        occupancy,
        vipOnly,
        images,
        tags,
        notifications,
      ];

  factory ProgrammeEntry.structure(ProgEntry entry, ProgEntryRun run) =>
      ProgrammeEntry(
        id: run.id,
        timestamp: run.timestamp,
        duration: run.duration,
        name: entry.name,
        subTitle: entry.subTitle,
        desc: entry.desc,
        type: entry.type,
        lang: run.lang ?? entry.lang,
        placeRef: run.placeRef ?? entry.placeRef,
        acting: run.acting ?? entry.acting,
        requireSignUp: run.requireSignUp,
        price: run.price,
        capacity: run.capacity,
        occupancy: run.occupancy,
        vipOnly: run.vipOnly,
        images: entry.images,
        tags: entry.tags,
        notifications: entry.notifications,
      );
}

@JsonSerializable()
class Programme extends Equatable {
  final Map<String, ProgEntry> entries;
  final Map<String, ProgPlace> places;
  final List<ProgNotification> notifications;
  final List<Extras> extras;

  const Programme({
    this.entries = const {},
    this.places = const {},
    this.notifications = const [],
    this.extras = const [],
  });

  @override
  List<Object?> get props => [entries, places, notifications, extras];

  factory Programme.fromJson(Map<String, Object?> json) =>
      _$ProgrammeFromJson(json);

  Map<String, Object?> toJson() => _$ProgrammeToJson(this);
}

enum ProgEntryType {
  concert,
  storyline,
  workshop,
  lecture,
  tournament,
  show,
  degustation,
  discussion,
  gaming,
  cosplay,
  other,
}

enum ProgEntryLang { cs, en }

@JsonSerializable()
class ProgEntry extends Equatable {
  final Map<String, String> name;
  final Map<String, String>? subTitle;
  final ProgEntryType type;
  final Map<String, ProgEntryRun> entryRuns;
  final ProgEntryLang lang;
  final String? placeRef;
  final Map<String, String>? desc;
  final Map<String, String>? acting;
  final List<String> images;
  final Set<String> tags;
  final List<ProgNotification> notifications;

  const ProgEntry({
    required this.name,
    this.subTitle,
    required this.type,
    required this.entryRuns,
    this.lang = ProgEntryLang.cs,
    required this.placeRef,
    this.desc,
    this.acting,
    this.images = const [],
    this.tags = const {},
    this.notifications = const [],
  });

  @override
  List<Object?> get props => [
        name,
        subTitle,
        type,
        lang,
        placeRef,
        desc,
        acting,
        images,
        tags,
        notifications,
      ];

  factory ProgEntry.fromJson(Map<String, Object?> json) =>
      _$ProgEntryFromJson(json);

  Map<String, Object?> toJson() => _$ProgEntryToJson(this);
}

@JsonSerializable()
class ProgEntryRun extends Equatable {
  final String id;
  final DateTime timestamp;
  final int duration;
  final ProgEntryLang? lang;
  final String? placeRef;
  final Map<String, String>? acting;
  final bool requireSignUp;
  final int? price;
  final int? capacity;
  final int? occupancy;
  final bool vipOnly;

  const ProgEntryRun({
    required this.id,
    required this.timestamp,
    required this.duration,
    this.lang,
    this.placeRef,
    this.acting,
    this.requireSignUp = false,
    this.price,
    this.capacity,
    this.occupancy,
    this.vipOnly = false,
  });

  @override
  List<Object?> get props => [
        timestamp,
        duration,
        lang,
        placeRef,
        acting,
        requireSignUp,
        price,
        capacity,
        occupancy,
        vipOnly,
      ];

  factory ProgEntryRun.fromJson(Map<String, Object?> json) =>
      _$ProgEntryRunFromJson(json);

  Map<String, Object?> toJson() => _$ProgEntryRunToJson(this);
}

@JsonSerializable()
class ProgPlace extends Equatable {
  final Map<String, String> name;
  final ProgPlaceLoc? loc;
  final List<String> images;

  const ProgPlace({
    required this.name,
    this.loc,
    this.images = const [],
  });

  @override
  List<Object?> get props => [name, loc, images];

  factory ProgPlace.fromJson(Map<String, Object?> json) =>
      _$ProgPlaceFromJson(json);

  Map<String, Object?> toJson() => _$ProgPlaceToJson(this);
}

@JsonSerializable()
class ProgPlaceLoc extends Equatable {
  final String mapRef;
  final String pointRef;

  const ProgPlaceLoc({
    required this.mapRef,
    required this.pointRef,
  });

  @override
  List<Object?> get props => [mapRef, pointRef];

  factory ProgPlaceLoc.fromJson(Map<String, Object?> json) =>
      _$ProgPlaceLocFromJson(json);

  Map<String, Object?> toJson() => _$ProgPlaceLocToJson(this);
}

@JsonSerializable()
class ProgNotification extends Equatable {
  final String? parrentEntry;
  final DateTime timestamp;
  final Map<String, String> message;

  const ProgNotification({
    this.parrentEntry,
    required this.timestamp,
    required this.message,
  });

  @override
  List<Object?> get props => [];

  factory ProgNotification.fromJson(Map<String, Object?> json) =>
      _$ProgNotificationFromJson(json);

  Map<String, Object?> toJson() => _$ProgNotificationToJson(this);
}
