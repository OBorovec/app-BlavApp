import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'degus_item.g.dart';

@JsonSerializable()
class DegusItem extends Equatable {
  final String id;
  final Map<String, String>? name;

  const DegusItem({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id];

  factory DegusItem.fromJson(Map<String, Object?> json) =>
      _$DegusItemFromJson(json);
  Map<String, Object?> toJson() => _$DegusItemToJson(this);
}
