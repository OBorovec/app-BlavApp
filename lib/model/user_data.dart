import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_data.g.dart';

@JsonSerializable()
class UserData extends Equatable {
  final Set<String> myNotifications;
  final Set<String> myProgramme;
  final List<Ticket> tickets;

  const UserData({
    this.myNotifications = const {},
    this.myProgramme = const {},
    this.tickets = const [],
  });

  @override
  List<Object?> get props => [myNotifications, myProgramme, tickets];

  factory UserData.fromJson(Map<String, Object?> json) =>
      _$UserDataFromJson(json);

  Map<String, Object?> toJson() => _$UserDataToJson(this);
}

@JsonSerializable()
class Ticket extends Equatable {
  final String eventRef;
  final String qrCodeData;

  const Ticket({
    required this.eventRef,
    required this.qrCodeData,
  });

  @override
  List<Object?> get props => [eventRef, qrCodeData];

  factory Ticket.fromJson(Map<String, Object?> json) => _$TicketFromJson(json);

  Map<String, Object?> toJson() => _$TicketToJson(this);
}
