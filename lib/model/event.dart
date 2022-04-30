import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable()
class Event extends Equatable {
  final String id;
  final String location;
  final Map<String, String> name;
  final Map<String, String>? desc;
  final DateTime timestampStart;
  final DateTime timestampEnd;
  final Routing routing;

  const Event({
    required this.id,
    required this.location,
    required this.name,
    required this.desc,
    required this.timestampStart,
    required this.timestampEnd,
    required this.routing,
  });

  @override
  List<Object?> get props => [id];

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

  const Routing({
    this.catering = false,
    this.cosplay = false,
    this.degustation = false,
    this.divisions = false,
    this.maps = false,
    this.programme = false,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  factory Routing.fromJson(Map<String, dynamic> json) =>
      _$RoutingFromJson(json);
  Map<String, dynamic> toJson() => _$RoutingToJson(this);
}
