import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:linkedin/model/ChatMessageEntity.dart';
import 'package:linkedin/widgets/chatBubble.dart';
import 'package:linkedin/widgets/chatInput.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatMessageEntity> _messages = [
    /*
    ChatMessageEntity(
        message: "Hi there",
        createdAt: 123242342,
        id: 1,
        author: Author(name: "Stefan")),
    ChatMessageEntity(
        message: "Hi there",
        createdAt: 123242342,
        id: 1,
        imageURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Scoot_logo.svg/800px-Scoot_logo.svg.png",
        author: Author(name: "Poja")),
    ChatMessageEntity(
        message: "Hi there",
        createdAt: 123242342,
        id: 1,
        author: Author(name: "Poja")),
        */
  ];

  @override
  void initState() {
    super.initState();
    _loadInitialMessage();
  }

  _loadInitialMessage() async {
    final res = await rootBundle.loadString("assets/mockData.json");

    final List decodedRes = jsonDecode(res) as List;

    final List<ChatMessageEntity> entities =
        decodedRes.map((e) => ChatMessageEntity.fromJson(e)).toList();

    setState(() {
      _messages = entities;
    });
  }

  _onSubmitChatInput(ChatMessageEntity chatMessageEntity) {
    setState(() {
      _messages.add(chatMessageEntity);
    });
  }

  @override
  Widget build(BuildContext context) {
    final username = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        //elevation: 0,
        title: Text("Hello $username"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (() {
                Navigator.of(context).popAndPushNamed('/LoginScreen');
              }),
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ChatBubble(
                  alignment: _messages[index].author.name == "Stefan"
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  chatMessage: _messages[index],
                );
              },
              itemCount: _messages.length,
            ),
          ),
          ChatInput(onSubmit: _onSubmitChatInput),
        ],
      ),
    );
  }
}
