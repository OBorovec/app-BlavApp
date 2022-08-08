import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_data.g.dart';

@JsonSerializable()
class UserData extends Equatable {
  final List<String> tickets;
  final Set<String> myNotifications;
  final Set<String> myProgramme;
  final Set<String> favoriteSamples;
  final Map<String, double> myRatings;
  final Map<String, bool?> myVoting;

  const UserData({
    this.tickets = const [],
    this.myNotifications = const {},
    this.myProgramme = const {},
    this.favoriteSamples = const {},
    this.myRatings = const {},
    this.myVoting = const {},
  });

  @override
  List<Object?> get props => [
        tickets,
        myNotifications,
        myProgramme,
        favoriteSamples,
        myRatings,
        myVoting,
      ];

  factory UserData.fromJson(Map<String, Object?> json) =>
      _$UserDataFromJson(json);

  Map<String, Object?> toJson() => _$UserDataToJson(this);
}
