import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/freeboard/post_model.dart';

//TODO - Firestore와 통신하는 API 담당 클래스
class FreeBoardApiService {
  final _col = FirebaseFirestore.instance.collection("posts");

  Stream<List<PostModel>> streamPosts() {
    return _col
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => PostModel.fromDoc(d)).toList());
  }

  Future<void> createPost(String title, String content) async {
    await _col.add({
      "title": title,
      "content": content,
      "likes": 0,
      "createdAt": Timestamp.now(),
      "updatedAt": null,
    });
  }

  Future<void> updatePost(String id, String title, String content) async {
    await _col.doc(id).update({
      "title": title,
      "content": content,
      "updatedAt": Timestamp.now(),
    });
  }

  Future<void> deletePost(String id) async {
    await _col.doc(id).delete();
  }

  Future<void> likePost(String id, int currentLikes) async {
    await _col.doc(id).update({
      "likes": currentLikes + 1,
    });
  }
}
