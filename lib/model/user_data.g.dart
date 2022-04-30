// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      myNotifications: (json['myNotifications'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toSet(),
      myProgramme: (json['myProgramme'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toSet(),
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'myNotifications': instance.myNotifications.toList(),
      'myProgramme': instance.myProgramme.toList(),
    };
