// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      tickets: (json['tickets'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      myNotifications: (json['myNotifications'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toSet() ??
          const {},
      myProgramme: (json['myProgramme'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toSet() ??
          const {},
      favoriteSamples: (json['favoriteSamples'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toSet() ??
          const {},
      myRatings: (json['myRatings'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toDouble()),
          ) ??
          const {},
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'tickets': instance.tickets,
      'myNotifications': instance.myNotifications.toList(),
      'myProgramme': instance.myProgramme.toList(),
      'favoriteSamples': instance.favoriteSamples.toList(),
      'myRatings': instance.myRatings,
    };
