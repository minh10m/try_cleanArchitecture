import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SendMessageEvent extends ChatEvent {
  final String receiverID;
  final String message;

  SendMessageEvent({required this.receiverID, required this.message});

  @override
  List<Object> get props => [receiverID, message];
}

class FetchMessagesEvent extends ChatEvent {
  final String userID;
  final String otherUserID;

  FetchMessagesEvent({required this.userID, required this.otherUserID});

  @override
  List<Object> get props => [userID, otherUserID];
}
