import 'package:blavapp/model/common.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable()
class Event extends Equatable {
  final String id;
  final String location;
  final Map<String, String> name;
  final Map<String, String>? sDesc;
  final Map<String, String>? desc;
  final List<Extras> extras;
  final List<BoardNote> board;
  final DateTime dayStart;
  final DateTime dayEnd;
  final Routing routing;
  final List<String> images;
  final bool canBeFocused;
  final bool isVisible;

  const Event({
    required this.id,
    required this.location,
    required this.name,
    required this.sDesc,
    required this.desc,
    this.extras = const [],
    this.board = const [],
    required this.dayStart,
    required this.dayEnd,
    required this.routing,
    this.images = const [],
    this.canBeFocused = false,
    this.isVisible = true,
  });

  @override
  List<Object?> get props => [
        id,
        location,
        name,
        sDesc,
        desc,
        extras,
        board,
        dayStart,
        dayEnd,
        images,
        routing,
        canBeFocused,
        isVisible
      ];

  factory Event.fromJson(Map<String, Object?> json) => _$EventFromJson(json);
  Map<String, Object?> toJson() => _$EventToJson(this);
}

@JsonSerializable()
class Routing extends Equatable {
  final bool catering;
  final bool cosplay;
  final bool degustation;
  final bool divisions;
  final bool maps;
  final bool programme;
  final bool story;
  final bool contacts;

  const Routing({
    this.catering = false,
    this.cosplay = false,
    this.degustation = false,
    this.divisions = false,
    this.maps = false,
    this.programme = false,
    this.story = false,
    this.contacts = false,
  });

  @override
  List<Object?> get props => [
        catering,
        cosplay,
        degustation,
        divisions,
        maps,
        programme,
        story,
      ];

  factory Routing.fromJson(Map<String, dynamic> json) =>
      _$RoutingFromJson(json);
  Map<String, dynamic> toJson() => _$RoutingToJson(this);
}

@JsonSerializable()
class BoardNote extends Equatable {
  final String id;
  final Map<String, String> title;
  final Map<String, String> body;

  const BoardNote({
    required this.id,
    required this.title,
    required this.body,
  });

  @override
  List<Object?> get props => [id, title, body];

  factory BoardNote.fromJson(Map<String, dynamic> json) =>
      _$BoardNoteFromJson(json);
  Map<String, dynamic> toJson() => _$BoardNoteToJson(this);
}
