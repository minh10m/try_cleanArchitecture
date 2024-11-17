import 'package:clean_architecture/data/service/authentication.dart';
import 'package:clean_architecture/presentation/ui/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../data/service/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;

  ChatPage({super.key, required this.receiverEmail, required this.receiverID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  final ChatService _chatService = ChatService();

  final AuthenticationService _authenticationService = AuthenticationService();


  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(widget.receiverID, _messageController.text);

      _messageController.clear();
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
              child: _buildMessageList(),
          ),

          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = _authenticationService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(widget.receiverID, senderID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          return ListView(
            children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList()
          );
        }
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data['senderID'] == _authenticationService.getCurrentUser()!.uid;

    var alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;



    return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start ,
          children: [
            ChatBubble(
                isCurrentUser: isCurrentUser,
                message: data['message']
            ),
          ]
        )
    );
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: Row(
        children: [
          const SizedBox(width: 20,),

          Expanded(
              child: TextField(
                controller: _messageController,
                obscureText: false,
                decoration: const InputDecoration(
                  hintText: "nhập ở đây",
                  fillColor: Colors.black,
                  border: OutlineInputBorder()
                ),
              )
          ),

          const SizedBox(width: 10,),

          Container(
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              shape: BoxShape.circle
            ),
            margin: const EdgeInsets.only(right: 15),
            child: IconButton(
                onPressed: sendMessage,
                icon: const Icon(Icons.arrow_upward, color: Colors.white,)
            ),
          )
        ],
      ),
    );
  }
}
