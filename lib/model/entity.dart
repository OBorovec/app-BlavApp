import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'entity.g.dart';

@JsonSerializable()
class Entity extends Equatable {
  final String id;
  final Map<String, String> name;
  final Map<String, String>? desc;
  final List<String> images;
  final Socials socials;

  const Entity({
    required this.id,
    required this.name,
    this.desc,
    this.images = const [],
    required this.socials,
  });

  @override
  List<Object?> get props => [id];

  factory Entity.fromJson(Map<String, Object?> json) => _$EntityFromJson(json);
  Map<String, Object?> toJson() => _$EntityToJson(this);
}

@JsonSerializable()
class Socials extends Equatable {
  final String? instagram;
  final String? facebook;
  final String? twitter;

  const Socials({
    this.instagram,
    this.facebook,
    this.twitter,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  factory Socials.fromJson(Map<String, dynamic> json) =>
      _$SocialsFromJson(json);
  Map<String, dynamic> toJson() => _$SocialsToJson(this);
}
