import 'package:flutter/material.dart';
import '../../model/freeboard/writing_model.dart';

class CommentViewModel extends ChangeNotifier {
  final List<CommentModel> _comments = [];

  //특정 게시글의 댓글 목록 불러오기
  List<CommentModel> getCommentsByPost(String postId) {
    return _comments.where((c) => c.postId == postId).toList();
  }

  // 댓글 추가
  void addComment({
    required String postId,
    required String writer,
    required String content,
  }) {
    final comment = CommentModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      postId: postId,
      writer: writer,
      content: content,
      createdAt: DateTime.now(),
      likes: 0,
    );

    _comments.insert(0, comment);
    notifyListeners();
  }

  // 댓글 좋아요
  void likeComment(String commentId) {
    final index = _comments.indexWhere((c) => c.id == commentId);
    if (index != -1) {
      _comments[index].likes++;
      notifyListeners();
    }
  }
}
