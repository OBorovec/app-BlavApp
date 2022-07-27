import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'programme.g.dart';

@JsonSerializable()
class Programme extends Equatable {
  final List<ProgEntry> entries;
  final List<ProgNotification> notifications;

  const Programme({
    required this.entries,
    this.notifications = const [],
  });

  @override
  List<Object?> get props => [entries];

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
  final Map<String, String>? desc;
  final Map<String, String>? sDesc;
  final String? placeRef;
  final DateTime timestamp;
  final int duration;
  final bool allDayEntry;
  final int? price;
  final String? performing;
  final String? organizer;
  final List<String> sponsor;
  final String? contactPageID;
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
    this.desc,
    this.sDesc,
    required this.placeRef,
    required this.timestamp,
    required this.duration,
    this.allDayEntry = false,
    this.price,
    this.performing,
    this.organizer,
    this.sponsor = const [],
    this.contactPageID,
    this.capacity,
    this.occupancy,
    this.vipOnly = false,
    this.images = const [],
    this.tags = const {},
    this.notifications = const [],
  });

  @override
  List<Object?> get props => [id, timestamp, placeRef];

  factory ProgEntry.fromJson(Map<String, Object?> json) =>
      _$ProgEntryFromJson(json);

  Map<String, Object?> toJson() => _$ProgEntryToJson(this);
}

@JsonSerializable()
class ProgNotification extends Equatable {
  final String? parrentEntry;
  final DateTime timestamp;
  final Map<String, String> message;

  const ProgNotification({
    required this.parrentEntry,
    required this.timestamp,
    required this.message,
  });

  @override
  List<Object?> get props => [];

  factory ProgNotification.fromJson(Map<String, Object?> json) =>
      _$ProgNotificationFromJson(json);

  Map<String, Object?> toJson() => _$ProgNotificationToJson(this);
}
