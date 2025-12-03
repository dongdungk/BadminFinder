import 'package:cloud_firestore/cloud_firestore.dart';

//TODO - 댓글 데이터 모델
class CommentModel {
  final String id;
  final String postId;
  final String content;
  final DateTime createdAt;
  final String nickname;
  final String userId;

  CommentModel({
    required this.id,
    required this.postId,
    required this.content,
    required this.createdAt,
    required this.nickname,
    required this.userId,
  });

  factory CommentModel.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    return CommentModel(
      id: doc.id,
      postId: (data["postId"] ?? "").toString(),
      content: (data["content"] ?? "").toString(),
      createdAt: (data["createdAt"] as Timestamp?)?.toDate() ?? DateTime.now(),
      nickname: (data["nickname"] ?? "익명").toString(),
      userId: (data["userId"] ?? "").toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "postId": postId,
      "content": content,
      "createdAt": Timestamp.now(),
      "nickname": nickname,
      "userId": userId,
    };
  }
}
