import 'package:injectable/injectable.dart';
import '../model/message/message.dart';
import '../service/chat_service.dart';

@singleton
class ChatRepository {
  final ChatService _chatService;

  ChatRepository({required ChatService chatService}) : _chatService = chatService;

  Future<void> sendMessage(String receiverID, String message) {
    return _chatService.sendMessage(receiverID, message);
  }

  Stream<List<Message>> getMessages(String userID, String otherUserID) {
    return _chatService.getMessages(userID, otherUserID)
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Message.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _chatService.getUsersStream();
  }
}
