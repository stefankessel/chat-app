class ChatMessageEntity {
  String message;
  int id;
  int createdAt;
  String? imageURL;
  Author author;

  ChatMessageEntity({
    required this.message,
    required this.createdAt,
    required this.id,
    this.imageURL,
    required this.author,
  });

  factory ChatMessageEntity.fromJson(Map<String, dynamic> json) {
    return ChatMessageEntity(
        message: json["message"],
        createdAt: json["createdAt"],
        id: int.parse(json["id"]),
        author: Author(name: json["author"]["name"]));
  }
}

class Author {
  String name;

  Author({required this.name});
}
