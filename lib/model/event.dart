import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable()
class Event extends Equatable {
  final String id;
  final String location;
  final Map<String, String> name;
  final Map<String, String>? desc;
  final DateTime dayStart;
  final DateTime dayEnd;
  final List<String> images;
  final Routing routing;
  final bool canBeFocused;

  const Event({
    required this.id,
    required this.location,
    required this.name,
    required this.desc,
    required this.dayStart,
    required this.dayEnd,
    this.images = const [],
    required this.routing,
    this.canBeFocused = false,
  });

  @override
  List<Object?> get props => [
        id,
        location,
        name,
        desc,
        dayStart,
        dayEnd,
        images,
        routing,
        canBeFocused
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

  const Routing({
    this.catering = false,
    this.cosplay = false,
    this.degustation = false,
    this.divisions = false,
    this.maps = false,
    this.programme = false,
    this.story = false,
  });

  @override
  // TODO: implement props
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
