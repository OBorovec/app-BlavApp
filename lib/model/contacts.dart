import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contacts.g.dart';

@JsonSerializable()
class Contacts extends Equatable {
  final Map<String, String>? instruction;
  final Map<String, ContactEntity> entities;
  final Map<String, ContactEntity> stroyEntities;

  const Contacts({
    this.instruction,
    this.entities = const {},
    this.stroyEntities = const {},
  });

  @override
  List<Object?> get props => [instruction, entities, stroyEntities];

  factory Contacts.fromJson(Map<String, Object?> json) =>
      _$ContactsFromJson(json);

  Map<String, Object?> toJson() => _$ContactsToJson(this);
}

@JsonSerializable()
class ContactEntity extends Equatable {
  final String id;
  final String name;
  final Map<String, String> type;
  final Map<String, String>? sDesc;
  final Map<String, String>? desc;
  final String? tel;
  final String? email;
  final String? messenger;
  final String? whatsapp;
  final String? telegram;
  final String? viber;
  final String? instagram;
  final List<String> images;
  final List<ContactPlace> commonPlaces;
  final ContactPlace? currentPlaceRef;

  const ContactEntity({
    required this.id,
    required this.name,
    required this.type,
    this.sDesc,
    this.desc,
    this.tel,
    this.email,
    this.messenger,
    this.whatsapp,
    this.telegram,
    this.viber,
    this.instagram,
    this.images = const [],
    this.commonPlaces = const [],
    this.currentPlaceRef,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        sDesc,
        desc,
        tel,
        email,
        messenger,
        whatsapp,
        telegram,
        viber,
        instagram,
        images,
        commonPlaces,
        currentPlaceRef,
      ];

  factory ContactEntity.fromJson(Map<String, Object?> json) =>
      _$ContactEntityFromJson(json);

  Map<String, Object?> toJson() => _$ContactEntityToJson(this);
}

@JsonSerializable()
class ContactPlace extends Equatable {
  final String map;
  final String placeRef;

  const ContactPlace({
    required this.map,
    required this.placeRef,
  });

  @override
  List<Object?> get props => [map, placeRef];

  factory ContactPlace.fromJson(Map<String, Object?> json) =>
      _$ContactPlaceFromJson(json);

  Map<String, Object?> toJson() => _$ContactPlaceToJson(this);
}
