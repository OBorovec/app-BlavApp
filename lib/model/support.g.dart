// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportVoting _$SupportVotingFromJson(Map<String, dynamic> json) =>
    SupportVoting(
      votes: (json['votes'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Map<String, bool?>.from(e as Map)),
          ) ??
          const {},
    );

Map<String, dynamic> _$SupportVotingToJson(SupportVoting instance) =>
    <String, dynamic>{
      'votes': instance.votes,
    };
