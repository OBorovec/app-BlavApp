import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cont_entry.g.dart';

@JsonSerializable()
class ContEntry extends Equatable {
  final String id;
  final Map<String, String> name;
  final Map<String, String>? desc;
  final List<String> images;
  final Socials socials;

  const ContEntry({
    required this.id,
    required this.name,
    this.desc,
    this.images = const [],
    required this.socials,
  });

  @override
  List<Object?> get props => [id];

  factory ContEntry.fromJson(Map<String, Object?> json) =>
      _$ContEntryFromJson(json);
  Map<String, Object?> toJson() => _$ContEntryToJson(this);
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
