import 'package:flutter/material.dart';

class ChatInput extends StatelessWidget {
  ChatInput({Key? key}) : super(key: key);

  final _chatInputController = TextEditingController();

  sendMessage() {
    print("message: ${_chatInputController.text}");
    _chatInputController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 80,
      decoration: const BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: TextField(
              autofocus: true,
              controller: _chatInputController,
              textCapitalization: TextCapitalization.sentences,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Enter your Message here",
                hintStyle: TextStyle(color: Colors.blueGrey),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              sendMessage();
            },
            icon: const Icon(
              Icons.send,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
