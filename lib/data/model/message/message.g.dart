// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      senderID: json['senderID'] as String,
      senderEmail: json['senderEmail'] as String,
      receiverID: json['receiverID'] as String,
      message: json['message'] as String,
      timestamp: Message._timestampFromJson(json['timestamp'] as Timestamp),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'senderID': instance.senderID,
      'senderEmail': instance.senderEmail,
      'receiverID': instance.receiverID,
      'message': instance.message,
      'timestamp': Message._timestampToJson(instance.timestamp),
    };
