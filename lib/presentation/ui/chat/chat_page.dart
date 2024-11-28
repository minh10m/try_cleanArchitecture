import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/message/message.dart';
import '../../../data/service/authentication.dart';
import '../../bloc/chat/chat_bloc.dart';
import '../../bloc/chat/chat_event.dart';
import '../../bloc/chat/chat_state.dart';
import 'chat_bubble.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;

  ChatPage({super.key, required this.receiverEmail, required this.receiverID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Gọi sự kiện để tải tin nhắn khi mở màn hình chat
    context.read<ChatBloc>().add(FetchMessagesEvent(
      userID: AuthenticationService().getCurrentUser()!.uid,
      otherUserID: widget.receiverID,
    ));
  }

  void sendMessage() {
    if (_messageController.text.isNotEmpty) {
      // Gọi sự kiện gửi tin nhắn
      context.read<ChatBloc>().add(SendMessageEvent(
        receiverID: widget.receiverID,
        message: _messageController.text,
      ));
      _messageController.clear();
      context.read<ChatBloc>().add(FetchMessagesEvent(
        userID: AuthenticationService().getCurrentUser()!.uid,
        otherUserID: widget.receiverID,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.receiverEmail}'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatMessagesLoadingState) {
                  return CircularProgressIndicator();
                } else if (state is ChatMessagesLoadedState) {
                  return ListView.builder(
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      return _buildMessageItem(state.messages[index]);
                    },
                  );
                } else if (state is ChatErrorState) {
                  return Text('Error: ${state.error}');
                }
                return Center(child: Text("No messages"));
              },
            ),
          ),
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageItem(Message message) {
    bool isCurrentUser = message.senderID == AuthenticationService().getCurrentUser()!.uid;
    var alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(
            isCurrentUser: isCurrentUser,
            message: message.message,
          ),
        ],
      ),
    );
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: Row(
        children: [
          const SizedBox(width: 20),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: "Nhập tin nhắn...",
                fillColor: Colors.black,
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 15),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(Icons.arrow_upward, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
