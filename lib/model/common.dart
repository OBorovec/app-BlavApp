import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'common.g.dart';

@JsonSerializable()
class Extras extends Equatable {
  final Map<String, String> title;
  final Map<String, String> body;

  const Extras({
    required this.title,
    required this.body,
  });

  @override
  List<Object?> get props => [title, body];

  factory Extras.fromJson(Map<String, Object?> json) => _$ExtrasFromJson(json);

  Map<String, Object?> toJson() => _$ExtrasToJson(this);
}
