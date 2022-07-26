// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      id: json['id'] as String,
      location: json['location'] as String,
      name: Map<String, String>.from(json['name'] as Map),
      sDesc: (json['sDesc'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      desc: (json['desc'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      extras: (json['extras'] as List<dynamic>?)
              ?.map((e) => Extras.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      board: (json['board'] as List<dynamic>?)
              ?.map((e) => BoardNote.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      dayStart: DateTime.parse(json['dayStart'] as String),
      dayEnd: DateTime.parse(json['dayEnd'] as String),
      routing: Routing.fromJson(json['routing'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      canBeFocused: json['canBeFocused'] as bool? ?? false,
      isVisible: json['isVisible'] as bool? ?? true,
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'location': instance.location,
      'name': instance.name,
      'sDesc': instance.sDesc,
      'desc': instance.desc,
      'extras': instance.extras,
      'board': instance.board,
      'dayStart': instance.dayStart.toIso8601String(),
      'dayEnd': instance.dayEnd.toIso8601String(),
      'routing': instance.routing,
      'images': instance.images,
      'canBeFocused': instance.canBeFocused,
      'isVisible': instance.isVisible,
    };

Routing _$RoutingFromJson(Map<String, dynamic> json) => Routing(
      catering: json['catering'] as bool? ?? false,
      cosplay: json['cosplay'] as bool? ?? false,
      degustation: json['degustation'] as bool? ?? false,
      divisions: json['divisions'] as bool? ?? false,
      maps: json['maps'] as bool? ?? false,
      programme: json['programme'] as bool? ?? false,
      story: json['story'] as bool? ?? false,
      contacts: json['contacts'] as bool? ?? false,
    );

Map<String, dynamic> _$RoutingToJson(Routing instance) => <String, dynamic>{
      'catering': instance.catering,
      'cosplay': instance.cosplay,
      'degustation': instance.degustation,
      'divisions': instance.divisions,
      'maps': instance.maps,
      'programme': instance.programme,
      'story': instance.story,
      'contacts': instance.contacts,
    };

BoardNote _$BoardNoteFromJson(Map<String, dynamic> json) => BoardNote(
      id: json['id'] as String,
      title: Map<String, String>.from(json['title'] as Map),
      body: Map<String, String>.from(json['body'] as Map),
    );

Map<String, dynamic> _$BoardNoteToJson(BoardNote instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
    };
