import 'package:cloud_firestore/cloud_firestore.dart';

//TODO - 게시글 모델
class PostModel {
  final String id;
  final String title;
  final String content;
  final String icon;
  final int likes;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String userId; // ✅ 작성자 UID

  PostModel({
    required this.id,
    required this.title,
    required this.content,
    required this.icon,
    required this.likes,
    required this.createdAt,
    this.updatedAt,
    required this.userId,
  });

  factory PostModel.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    return PostModel(
      id: doc.id,
      title: (data["title"] ?? "").toString(),
      content: (data["content"] ?? "").toString(),
      icon: (data["icon"] ?? "🏸").toString(),
      likes: (data["likes"] ?? 0) as int,
      createdAt: (data["createdAt"] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data["updatedAt"] as Timestamp?)?.toDate(),
      userId: (data["userId"] ?? "").toString(), // ✅ 추가
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "content": content,
      "icon": icon,
      "likes": likes,
      "createdAt": Timestamp.fromDate(createdAt),
      "updatedAt": updatedAt == null ? null : Timestamp.fromDate(updatedAt!),
      "userId": userId, // ✅ 추가
    };
  }
}
