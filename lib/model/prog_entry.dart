import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'prog_entry.g.dart';

enum ProgEntryType { concert, storyline, workshop, lecture, tournament, other }

@JsonSerializable()
class ProgEntry extends Equatable {
  final String id;
  final Map<String, String> name;
  final ProgEntryType type;
  final Map<String, String>? desc;
  final Map<String, String>? sDesc;
  final String placeID;
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

  ProgEntry({
    required this.id,
    required this.name,
    required this.type,
    this.desc,
    this.sDesc,
    required this.placeID,
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
  });

  @override
  List<Object?> get props => [id, timestamp, placeID];

  factory ProgEntry.fromJson(Map<String, Object?> json) =>
      _$ProgEntryFromJson(json);

  Map<String, Object?> toJson() => _$ProgEntryToJson(this);
}
