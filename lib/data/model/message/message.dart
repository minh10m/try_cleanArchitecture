import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';


@JsonSerializable()
class Message {
  final String senderID;
  final String senderEmail;
  final String receiverID;
  final String message;

  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final Timestamp timestamp;

  Message({
    required this.senderID,
    required this.senderEmail,
    required this.receiverID,
    required this.message,
    required this.timestamp,
  });

  // Phương thức từ JSON
  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  // Phương thức đến JSON
  Map<String, dynamic> toJson() => _$MessageToJson(this);

  static Timestamp _timestampFromJson(Timestamp timestamp) => timestamp;
  static Timestamp _timestampToJson(Timestamp timestamp) => timestamp;
}
