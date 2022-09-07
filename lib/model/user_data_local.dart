import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_data_local.g.dart';

@JsonSerializable()
class UserDataLocal extends Equatable {
  final Set<String> hiddenBoardNotes;
  final Set<String> tastedDegustations;

  const UserDataLocal({
    this.hiddenBoardNotes = const {},
    this.tastedDegustations = const {},
  });

  @override
  List<Object?> get props => [
        hiddenBoardNotes,
        tastedDegustations,
      ];

  factory UserDataLocal.fromJson(Map<String, Object?> json) =>
      _$UserDataLocalFromJson(json);

  Map<String, Object?> toJson() => _$UserDataLocalToJson(this);

  UserDataLocal copyWith({
    Set<String>? hiddenBoardNotes,
    Set<String>? tastedDegustations,
  }) {
    return UserDataLocal(
      hiddenBoardNotes: hiddenBoardNotes ?? this.hiddenBoardNotes,
      tastedDegustations: tastedDegustations ?? this.tastedDegustations,
    );
  }
}
