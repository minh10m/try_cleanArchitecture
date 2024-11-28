import 'package:injectable/injectable.dart';
import '../../data/model/message/message.dart';
import '../../data/repository/chat_repository.dart';

@singleton
class ChatUseCase {
  final ChatRepository _chatRepository;

  ChatUseCase({required ChatRepository chatRepository}) : _chatRepository = chatRepository;

  Future<void> sendMessage(String receiverID, String message) {
    return _chatRepository.sendMessage(receiverID, message);
  }

  Stream<List<Message>> getMessages(String userID, String otherUserID) {
    return _chatRepository.getMessages(userID, otherUserID);
  }

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _chatRepository.getUsersStream();
  }
}
