import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_data.g.dart';

@JsonSerializable()
class UserData extends Equatable {
  final Set<String> myNotifications;
  final Set<String> myProgramme;

  UserData({
    Set<String>? myNotifications,
    Set<String>? myProgramme,
  })  : myNotifications = myNotifications ?? <String>{},
        myProgramme = myProgramme ?? <String>{};

  @override
  List<Object?> get props => [myNotifications, myProgramme];

  factory UserData.fromJson(Map<String, Object?> json) =>
      _$UserDataFromJson(json);

  Map<String, Object?> toJson() => _$UserDataToJson(this);
}
