import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_data_local.g.dart';

@JsonSerializable()
class UserDataLocal extends Equatable {
  final Set<String> hiddenBoardNotes;

  const UserDataLocal({
    this.hiddenBoardNotes = const {},
  });

  @override
  List<Object?> get props => [
        hiddenBoardNotes,
      ];

  factory UserDataLocal.fromJson(Map<String, Object?> json) =>
      _$UserDataLocalFromJson(json);

  Map<String, Object?> toJson() => _$UserDataLocalToJson(this);

  UserDataLocal copyWith({
    Set<String>? hiddenBoardNotes,
  }) {
    return UserDataLocal(
      hiddenBoardNotes: hiddenBoardNotes ?? this.hiddenBoardNotes,
    );
  }
}
