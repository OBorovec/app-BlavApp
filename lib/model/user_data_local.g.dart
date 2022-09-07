// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_local.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDataLocal _$UserDataLocalFromJson(Map<String, dynamic> json) =>
    UserDataLocal(
      hiddenBoardNotes: (json['hiddenBoardNotes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toSet() ??
          const {},
      tastedDegustations: (json['tastedDegustations'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toSet() ??
          const {},
    );

Map<String, dynamic> _$UserDataLocalToJson(UserDataLocal instance) =>
    <String, dynamic>{
      'hiddenBoardNotes': instance.hiddenBoardNotes.toList(),
      'tastedDegustations': instance.tastedDegustations.toList(),
    };
