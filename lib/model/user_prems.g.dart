// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_prems.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPrems _$UserPremsFromJson(Map<String, dynamic> json) => UserPrems(
      roles: json['roles'] == null
          ? null
          : Roles.fromJson(json['roles'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserPremsToJson(UserPrems instance) => <String, dynamic>{
      'roles': instance.roles,
    };

Roles _$RolesFromJson(Map<String, dynamic> json) => Roles(
      org: json['org'] as bool? ?? false,
      vip: json['vip'] as bool? ?? false,
    );

Map<String, dynamic> _$RolesToJson(Roles instance) => <String, dynamic>{
      'org': instance.org,
      'vip': instance.vip,
    };
