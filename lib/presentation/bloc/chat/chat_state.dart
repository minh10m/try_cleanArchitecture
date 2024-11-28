import '../../../data/model/message/message.dart';

abstract class ChatState {}

class ChatInitialState extends ChatState {}

class ChatMessagesLoadingState extends ChatState {}

class ChatMessagesLoadedState extends ChatState {
  final List<Message> messages;

  ChatMessagesLoadedState({required this.messages});
}

class ChatMessageSentState extends ChatState {}

class ChatErrorState extends ChatState {
  final String error;

  ChatErrorState({required this.error});
}
