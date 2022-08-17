import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cosplay.g.dart';

@JsonSerializable()
class Cosplay extends Equatable {
  final List<CosplayRecord> cosplayRecords;

  const Cosplay({
    this.cosplayRecords = const [],
  });

  @override
  List<Object?> get props => [cosplayRecords];

  factory Cosplay.fromJson(Map<String, Object?> json) =>
      _$CosplayFromJson(json);

  Map<String, Object?> toJson() => _$CosplayToJson(this);
}

enum CosplayRecordLink { face, insta, twitter }

@JsonSerializable()
class CosplayRecord extends Equatable {
  final String id;
  final Map<String, String> name;
  final String profileImage;
  final String voteRef;
  final Map<String, String> desc;
  final Map<CosplayRecordLink, String> links;
  final List<String> images;

  const CosplayRecord({
    required this.id,
    required this.name,
    required this.profileImage,
    required this.voteRef,
    this.desc = const {},
    this.links = const {},
    this.images = const [],
  });

  @override
  List<Object?> get props =>
      [id, name, voteRef, desc, profileImage, links, images];

  factory CosplayRecord.fromJson(Map<String, Object?> json) =>
      _$CosplayRecordFromJson(json);

  Map<String, Object?> toJson() => _$CosplayRecordToJson(this);
}
