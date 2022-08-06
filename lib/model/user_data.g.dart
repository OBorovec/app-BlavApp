// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      myNotifications: (json['myNotifications'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toSet() ??
          const {},
      myProgramme: (json['myProgramme'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toSet() ??
          const {},
      tickets: (json['tickets'] as List<dynamic>?)
              ?.map((e) => Ticket.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'myNotifications': instance.myNotifications.toList(),
      'myProgramme': instance.myProgramme.toList(),
      'tickets': instance.tickets,
    };

Ticket _$TicketFromJson(Map<String, dynamic> json) => Ticket(
      eventRef: json['eventRef'] as String,
      qrCodeData: json['qrCodeData'] as String,
    );

Map<String, dynamic> _$TicketToJson(Ticket instance) => <String, dynamic>{
      'eventRef': instance.eventRef,
      'qrCodeData': instance.qrCodeData,
    };
