import 'package:flutter/material.dart';
import 'package:linkedin/model/ChatMessageEntity.dart';

class ChatBubble extends StatelessWidget {
  final Alignment alignment;
  final ChatMessageEntity chatMessage;
  const ChatBubble(
      {Key? key, required this.alignment, required this.chatMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (chatMessage.message.isNotEmpty)
              Text(
                chatMessage.message,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            if (chatMessage.imageURL != null &&
                chatMessage.imageURL!.isNotEmpty)
              Padding(
                padding: chatMessage.message.isEmpty
                    ? const EdgeInsets.only(top: 0)
                    : const EdgeInsets.only(top: 10),
                child: Image.network(
                  "${chatMessage.imageURL}",
                  height: 150,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
