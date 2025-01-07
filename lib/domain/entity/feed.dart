class Feed {
  int id;
  String userId;
  String imageUrl;
  List<String>? tag;
  String content;
  DateTime createdAt;
  //List<int>? comment
  int likeCnt = 0;
  bool isLike = false;

  Feed({
    required this.id,
    required this.userId,
    required this.imageUrl,
    this.tag,
    required this.content,
    required this.createdAt,
    required this.likeCnt,
    required this.isLike,
  });
}
