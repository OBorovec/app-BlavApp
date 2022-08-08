import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'support.g.dart';

@JsonSerializable()
class SupportVoting extends Equatable {
  final Map<String, Map<String, bool?>>? votes;

  const SupportVoting({
    this.votes = const {},
  });

  @override
  List<Object?> get props => [votes];

  factory SupportVoting.fromJson(Map<String, Object?> json) =>
      _$SupportVotingFromJson(json);
  Map<String, Object?> toJson() => _$SupportVotingToJson(this);
}
