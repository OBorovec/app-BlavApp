import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_perms.g.dart';

@JsonSerializable()
class UserPerms extends Equatable {
  final Roles roles;
  final bool hasAdmin;

  const UserPerms({
    this.roles = const Roles(),
    this.hasAdmin = false,
  });

  @override
  List<Object?> get props => [roles, hasAdmin];

  factory UserPerms.fromJson(Map<String, Object?> json) =>
      _$UserPermsFromJson(json);

  Map<String, Object?> toJson() => _$UserPermsToJson(this);
}

@JsonSerializable()
class Roles extends Equatable {
  final bool org;
  final bool vip;
  const Roles({
    this.org = false,
    this.vip = false,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  factory Roles.fromJson(Map<String, dynamic> json) => _$RolesFromJson(json);
  Map<String, dynamic> toJson() => _$RolesToJson(this);
}
