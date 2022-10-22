import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:linkedin/model/ChatMessageEntity.dart';
import 'package:linkedin/model/ImageEntity.dart';
import 'package:linkedin/repo/image_repository.dart';
import 'package:linkedin/widgets/chatBubble.dart';
import 'package:linkedin/widgets/chatInput.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatMessageEntity> _messages = [];
  final ImageRepository _imageRepository = ImageRepository();

  @override
  void initState() {
    super.initState();
    _loadInitialMessage();
    _imageRepository.getNetworkImages();
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
    _imageRepository.getNetworkImages();
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
          FutureBuilder(
            future: _imageRepository.getNetworkImages(),
            builder: (BuildContext context,
                AsyncSnapshot<List<ImageEntity>> snapshot) {
              if (snapshot.hasData) {
                return Image.network(snapshot.data![0].urlSmallSize);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
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
