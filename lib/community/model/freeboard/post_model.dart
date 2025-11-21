//커뮤니티 - 자유게시판 -게시글 model
class PostModel {
  final String id;
  final String icon;
  final String title;
  final String content;
  final String time;
  int views;
  int likes;

  PostModel({
    required this.id,
    required this.icon,
    required this.title,
    required this.content,
    required this.time,
    this.views = 0,
    this.likes = 0,
  });
}
