// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ticket _$TicketFromJson(Map<String, dynamic> json) => Ticket(
      value: json['value'] as String,
      eventRef: json['eventRef'] as String,
      ownerMail: json['ownerMail'] as String,
      ownerName: json['ownerName'] as String,
    );

Map<String, dynamic> _$TicketToJson(Ticket instance) => <String, dynamic>{
      'value': instance.value,
      'eventRef': instance.eventRef,
      'ownerMail': instance.ownerMail,
      'ownerName': instance.ownerName,
    };
