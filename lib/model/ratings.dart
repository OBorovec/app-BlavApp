import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ratings.g.dart';

@JsonSerializable()
class Ratings extends Equatable {
  final Map<String, Map<String, double>> ratings;

  const Ratings({
    this.ratings = const {},
  });

  @override
  List<Object?> get props => [ratings];

  factory Ratings.fromJson(Map<String, Object?> json) =>
      _$RatingsFromJson(json);

  Map<String, Object?> toJson() => _$RatingsToJson(this);
}
