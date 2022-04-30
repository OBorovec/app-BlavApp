import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_prems.g.dart';

@JsonSerializable()
class UserPrems extends Equatable {
  final Roles roles;

  const UserPrems({
    Roles? roles,
  }) : roles = roles ?? const Roles();

  @override
  List<Object?> get props => [roles];

  factory UserPrems.fromJson(Map<String, Object?> json) =>
      _$UserPremsFromJson(json);

  Map<String, Object?> toJson() => _$UserPremsToJson(this);
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
