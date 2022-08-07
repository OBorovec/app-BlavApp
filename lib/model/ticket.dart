import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ticket.g.dart';

@JsonSerializable()
class Ticket extends Equatable {
  final String value;
  final String eventRef;
  final String ownerMail;
  final String ownerName;

  const Ticket({
    required this.value,
    required this.eventRef,
    required this.ownerMail,
    required this.ownerName,
  });

  @override
  List<Object?> get props => [value, eventRef, ownerMail, ownerName];

  factory Ticket.fromJson(Map<String, Object?> json) => _$TicketFromJson(json);

  Map<String, Object?> toJson() => _$TicketToJson(this);
}
