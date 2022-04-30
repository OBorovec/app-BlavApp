import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'programme.g.dart';

@JsonSerializable()
class Programme extends Equatable {
  final List<ProgEntry> entries;
  final Map<String, ProgPlace> places;
  final List<ProgNotification> notifications;

  const Programme({
    this.entries = const [],
    this.places = const {},
    this.notifications = const [],
  });

  @override
  List<Object?> get props => [entries, places, notifications];

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
  photo,
  cosplay,
  other,
}

@JsonSerializable()
class ProgEntry extends Equatable {
  final String id;
  final Map<String, String> name;
  final ProgEntryType type;
  final String? placeRef;
  final DateTime timestamp;
  final int duration;
  final Map<String, String>? desc;
  final Map<String, String>? sDesc;
  final bool allDayEntry;
  final int? price;
  final String? performing;
  final String? organizer;
  final List<String> sponsor;
  final String? contactPageID;
  final bool requireSignUp;
  final int? capacity;
  final int? occupancy;
  final bool vipOnly;
  final List<String> images;
  final Set<String> tags;
  final List<ProgNotification> notifications;

  const ProgEntry({
    required this.id,
    required this.name,
    required this.type,
    required this.placeRef,
    required this.timestamp,
    required this.duration,
    this.desc,
    this.sDesc,
    this.allDayEntry = false,
    this.price,
    this.performing,
    this.organizer,
    this.sponsor = const [],
    this.contactPageID,
    this.requireSignUp = false,
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
        name,
        type,
        placeRef,
        timestamp,
        duration,
        desc,
        sDesc,
        allDayEntry,
        price,
        performing,
        organizer,
        sponsor,
        contactPageID,
        requireSignUp,
        capacity,
        occupancy,
        vipOnly,
        images,
        tags,
        notifications,
      ];

  factory ProgEntry.fromJson(Map<String, Object?> json) =>
      _$ProgEntryFromJson(json);

  Map<String, Object?> toJson() => _$ProgEntryToJson(this);
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
