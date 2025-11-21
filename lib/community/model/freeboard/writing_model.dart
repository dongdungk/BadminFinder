//커뮤니티 - 자유게시판 - 글 작성 model
class CommentModel {
  final String id;          //댓글 고유 ID
  final String postId;      //어떤 게시글의 댓글인지
  final String writer;      //작성자 이름
  final String content;     //댓글 내용
  final DateTime createdAt; //작성 시간
  int likes;                //좋아요 개수

  CommentModel({
    required this.id,
    required this.postId,
    required this.writer,
    required this.content,
    required this.createdAt,
    this.likes = 0,
  });
}
