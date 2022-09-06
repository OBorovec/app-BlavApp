// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportTicket _$SupportTicketFromJson(Map<String, dynamic> json) =>
    SupportTicket(
      creatorId: json['creatorId'] as String,
      title: json['title'] as String,
      content: (json['content'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      userPending: json['userPending'] as bool? ?? false,
      supportPending: json['supportPending'] as bool? ?? true,
      isClosed: json['isClosed'] as bool? ?? false,
    );

Map<String, dynamic> _$SupportTicketToJson(SupportTicket instance) =>
    <String, dynamic>{
      'creatorId': instance.creatorId,
      'title': instance.title,
      'content': instance.content,
      'userPending': instance.userPending,
      'supportPending': instance.supportPending,
      'isClosed': instance.isClosed,
    };
