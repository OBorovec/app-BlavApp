// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ratings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ratings _$RatingsFromJson(Map<String, dynamic> json) => Ratings(
      ratings: (json['ratings'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
                k,
                (e as Map<String, dynamic>).map(
                  (k, e) => MapEntry(k, (e as num).toDouble()),
                )),
          ) ??
          const {},
    );

Map<String, dynamic> _$RatingsToJson(Ratings instance) => <String, dynamic>{
      'ratings': instance.ratings,
    };
