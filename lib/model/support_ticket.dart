import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'support_ticket.g.dart';

@JsonSerializable()
class SupportTicket extends Equatable {
  final String creatorId;
  final String title;
  final List<String> content;
  final bool userPending;
  final bool supportPending;
  final bool isClosed;

  const SupportTicket({
    required this.creatorId,
    required this.title,
    this.content = const [],
    this.userPending = false,
    this.supportPending = true,
    this.isClosed = false,
  });

  @override
  List<Object?> get props => [
        creatorId,
        title,
        content,
        userPending,
        supportPending,
        isClosed,
      ];

  factory SupportTicket.fromJson(Map<String, Object?> json) =>
      _$SupportTicketFromJson(json);

  Map<String, Object?> toJson() => _$SupportTicketToJson(this);
}
