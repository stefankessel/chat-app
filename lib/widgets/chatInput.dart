import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:linkedin/services/auth_service.dart';
import 'package:linkedin/model/ChatMessageEntity.dart';
import 'package:linkedin/widgets/modalBottomImageContainer.dart';

class ChatInput extends StatefulWidget {
  final Function onSubmit;
  //final Function(String) onImageSelected;
  const ChatInput({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final _chatInputController = TextEditingController();
  String _imageSelected = "";

  _onSubmitMessage() {
    if (_chatInputController.text.isNotEmpty || _imageSelected.isNotEmpty) {
      final newMessage = ChatMessageEntity(
        message: _chatInputController.text,
        imageURL: _imageSelected,
        createdAt: DateTime.now().microsecondsSinceEpoch,
        id: 123,
        author: Author(name: context.read<AuthService>().user),
      );
      if (_imageSelected.isNotEmpty) {
        newMessage.imageURL = _imageSelected;
      }

      widget.onSubmit(newMessage);

      _chatInputController.clear();
      _imageSelected = '';
    }
  }

  _onImageSelected(String newImageURL) {
    _imageSelected = newImageURL;
    setState(() {});
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return ModalBottomImageContainer(
                    onImageSelected: _onImageSelected,
                  );
                },
              );
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Column(
              children: [
                TextField(
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
                if (_imageSelected.isNotEmpty)
                  Image.network(
                    _imageSelected,
                    height: 100,
                  ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _onSubmitMessage(),
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
