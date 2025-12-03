import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../model/freeboard/post_model.dart';

class FreeBoardViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<PostModel> posts = [];
  bool isLoading = false;
  String? errorMessage;

  String get currentUid => _auth.currentUser?.uid ?? "";

  // 좋아요 중복 방지
  final Set<String> _likedPostIds = {};
  bool isLiked(String postId) => _likedPostIds.contains(postId);

  // 숨김/차단 (로컬 필터)
  final Set<String> hiddenPostIds = {};
  final Set<String> blockedPostAuthorIds = {}; // uid 저장

  final Set<String> hiddenCommentIds = {};
  final Set<String> blockedCommentAuthorIds = {}; // uid 저장

  bool isHiddenPost(String postId) => hiddenPostIds.contains(postId);
  bool isBlockedPostAuthor(String authorUid) =>
      blockedPostAuthorIds.contains(authorUid);

  bool isHiddenComment(String commentId) => hiddenCommentIds.contains(commentId);
  bool isBlockedCommentAuthor(String authorUid) =>
      blockedCommentAuthorIds.contains(authorUid);

  // ---------------------------------------------------
  // 게시글 로드
  // ---------------------------------------------------
  Future<void> loadPosts() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final snap = await _firestore
          .collection("posts")
          .orderBy("createdAt", descending: true)
          .get();

      final raw = snap.docs.map((d) => PostModel.fromDoc(d)).toList();

      posts = raw.where((p) {
        if (hiddenPostIds.contains(p.id)) return false;
        if (blockedPostAuthorIds.contains(p.userId)) return false;
        return true;
      }).toList();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ---------------------------------------------------
  // 게시글 숨기기
  // ---------------------------------------------------
  void hidePost(String postId) {
    hiddenPostIds.add(postId);
    posts.removeWhere((p) => p.id == postId);
    notifyListeners();
  }

  // ---------------------------------------------------
  // 게시글 작성자 차단
  // ---------------------------------------------------
  void blockPostAuthor(String authorUid) {
    blockedPostAuthorIds.add(authorUid);
    posts.removeWhere((p) => p.userId == authorUid);
    notifyListeners();
  }

  // ---------------------------------------------------
  // 게시글 신고하기
  // ---------------------------------------------------
  Future<void> reportPost({
    required String postId,
    required String reason,
  }) async {
    await _firestore.collection("reports").add({
      "postId": postId,
      "reason": reason,
      "createdAt": Timestamp.now(),
      "type": "post",
      "reporterUid": currentUid,
    });
  }

  // ---------------------------------------------------
  // 게시글 작성
  // ---------------------------------------------------
  Future<void> createPost(String title, String content, String icon) async {
    await _firestore.collection("posts").add({
      "title": title,
      "content": content,
      "icon": icon.isEmpty ? "🏸" : icon,
      "likes": 0,
      "createdAt": Timestamp.now(),
      "updatedAt": null,
      "userId": currentUid,
    });
    await loadPosts();
  }

  // ---------------------------------------------------
  // ✅ 게시글 수정 (본인 글만)
  // ---------------------------------------------------
  Future<void> updatePost(
      String id, String title, String content, String icon) async {
    final doc = await _firestore.collection("posts").doc(id).get();
    final data = doc.data() as Map<String, dynamic>? ?? {};
    final ownerUid = (data["userId"] ?? "").toString();

    if (ownerUid != currentUid) {
      throw Exception("본인이 작성한 게시글만 수정할 수 있습니다.");
    }

    await _firestore.collection("posts").doc(id).update({
      "title": title,
      "content": content,
      "icon": icon.isEmpty ? "🏸" : icon,
      "updatedAt": Timestamp.now(),
    });
    await loadPosts();
  }

  // ---------------------------------------------------
  // 게시글 삭제 (본인 글만)
  // ---------------------------------------------------
  Future<void> deletePost(String id) async {
    final doc = await _firestore.collection("posts").doc(id).get();
    final data = doc.data() as Map<String, dynamic>? ?? {};
    final ownerUid = (data["userId"] ?? "").toString();

    if (ownerUid != currentUid) {
      throw Exception("본인이 작성한 게시글만 삭제할 수 있습니다.");
    }

    await _firestore.collection("posts").doc(id).delete();

    // ✅ 게시글 삭제 시 해당 댓글들 같이 삭제
    final commentsSnap = await _firestore
        .collection("comments")
        .where("postId", isEqualTo: id)
        .get();
    for (final c in commentsSnap.docs) {
      await c.reference.delete();
    }

    await loadPosts();
  }

  // ---------------------------------------------------
  // 좋아요 토글
  // ---------------------------------------------------
  Future<void> toggleLike(PostModel post) async {
    final ref = _firestore.collection("posts").doc(post.id);
    final liked = isLiked(post.id);

    final newLikes = liked ? (post.likes - 1) : (post.likes + 1);
    await ref.update({"likes": newLikes < 0 ? 0 : newLikes});

    if (liked) {
      _likedPostIds.remove(post.id);
    } else {
      _likedPostIds.add(post.id);
    }

    await loadPosts();
  }

  // ---------------------------------------------------
  // 댓글 스트림
  // ---------------------------------------------------
  Stream<QuerySnapshot> streamComments(String postId) {
    return _firestore
        .collection("comments")
        .where("postId", isEqualTo: postId)
        .orderBy("createdAt", descending: false)
        .snapshots();
  }

  // ---------------------------------------------------
  // 댓글 개수
  // ---------------------------------------------------
  Future<int> getCommentCount(String postId) async {
    final snap = await _firestore
        .collection("comments")
        .where("postId", isEqualTo: postId)
        .get();
    return snap.size;
  }

  // ---------------------------------------------------
  // 댓글 추가
  // ---------------------------------------------------
  Future<void> addComment(String postId, String content) async {
    await _firestore.collection("comments").add({
      "postId": postId,
      "content": content,
      "createdAt": Timestamp.now(),
      "nickname": "익명",
      "userId": currentUid,
    });
  }

  // ---------------------------------------------------
  // 댓글 수정 (본인 댓글만)
  // ---------------------------------------------------
  Future<void> editComment(String commentId, String newContent) async {
    final doc = await _firestore.collection("comments").doc(commentId).get();
    final data = doc.data() as Map<String, dynamic>? ?? {};
    final ownerUid = (data["userId"] ?? "").toString();

    if (ownerUid != currentUid) {
      throw Exception("본인이 작성한 댓글만 수정할 수 있습니다.");
    }

    await _firestore.collection("comments").doc(commentId).update({
      "content": newContent,
      "updatedAt": Timestamp.now(),
    });
  }

  // ---------------------------------------------------
  // 댓글 삭제
  //  - 본인 댓글 OR 내가 쓴 게시글의 댓글이면 삭제 가능
  // ---------------------------------------------------
  Future<void> deleteComment({
    required String commentId,
    required String postOwnerUid,
  }) async {
    final doc = await _firestore.collection("comments").doc(commentId).get();
    final data = doc.data() as Map<String, dynamic>? ?? {};
    final commentOwnerUid = (data["userId"] ?? "").toString();

    final canDelete =
        (commentOwnerUid == currentUid) || (postOwnerUid == currentUid);

    if (!canDelete) {
      throw Exception("본인 댓글 또는 내 게시글의 댓글만 삭제할 수 있습니다.");
    }

    await _firestore.collection("comments").doc(commentId).delete();
  }

  // ---------------------------------------------------
  // 댓글 신고
  // ---------------------------------------------------
  Future<void> reportComment({
    required String commentId,
    required String reason,
  }) async {
    await _firestore.collection("reports").add({
      "commentId": commentId,
      "reason": reason,
      "createdAt": Timestamp.now(),
      "type": "comment",
      "reporterUid": currentUid,
    });
  }

  // ---------------------------------------------------
  // 댓글 숨김 (로컬)
  // ---------------------------------------------------
  void hideComment(String commentId) {
    hiddenCommentIds.add(commentId);
    notifyListeners();
  }

  // ---------------------------------------------------
  // 댓글 작성자 차단 (uid 기반)
  // ---------------------------------------------------
  void blockCommentAuthor(String authorUid) {
    blockedCommentAuthorIds.add(authorUid);
    notifyListeners();
  }
}
