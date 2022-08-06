// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      id: json['id'] as String,
      location: json['location'] as String,
      name: Map<String, String>.from(json['name'] as Map),
      desc: (json['desc'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      dayStart: DateTime.parse(json['dayStart'] as String),
      dayEnd: DateTime.parse(json['dayEnd'] as String),
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      routing: Routing.fromJson(json['routing'] as Map<String, dynamic>),
      canBeFocused: json['canBeFocused'] as bool? ?? false,
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'location': instance.location,
      'name': instance.name,
      'desc': instance.desc,
      'dayStart': instance.dayStart.toIso8601String(),
      'dayEnd': instance.dayEnd.toIso8601String(),
      'images': instance.images,
      'routing': instance.routing,
      'canBeFocused': instance.canBeFocused,
    };

Routing _$RoutingFromJson(Map<String, dynamic> json) => Routing(
      catering: json['catering'] as bool? ?? false,
      cosplay: json['cosplay'] as bool? ?? false,
      degustation: json['degustation'] as bool? ?? false,
      divisions: json['divisions'] as bool? ?? false,
      maps: json['maps'] as bool? ?? false,
      programme: json['programme'] as bool? ?? false,
    );

Map<String, dynamic> _$RoutingToJson(Routing instance) => <String, dynamic>{
      'catering': instance.catering,
      'cosplay': instance.cosplay,
      'degustation': instance.degustation,
      'divisions': instance.divisions,
      'maps': instance.maps,
      'programme': instance.programme,
    };
