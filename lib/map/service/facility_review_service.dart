// lib/map/service/facility_review_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/facility_review_model.dart';

class ReviewService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _reviewCollection = FirebaseFirestore.instance.collection('reviews');

  // ----------------------------------------
  // A. 읽기 (Read)
  // ----------------------------------------
  Future<List<ReviewModel>> getReviews(String facilityId) async {
    try {
      final snapshot = await _reviewCollection
          .where('facilityId', isEqualTo: facilityId)
          .orderBy('date', descending: true)
          .get();

      // ⭐️ [FIX] 문서 ID(doc.id)를 함께 전달하며 ReviewModel로 변환
      return snapshot.docs
          .map((doc) => ReviewModel.fromFirestore(doc.data() as Map<String, dynamic>, doc.id))
          .toList();

    } catch (e) {
      print("Firestore Reviews Error: $e");
      return [];
    }
  }

  // ----------------------------------------
  // B. 쓰기 (Create)
  // ----------------------------------------
  Future<bool> addReview(ReviewModel review) async {
    try {
      await _reviewCollection.add(review.toJson());
      return true;
    } catch (e) {
      print("Error adding review: $e");
      return false;
    }
  }

  // ----------------------------------------
  // C. 수정 (Update)
  // ----------------------------------------
  Future<bool> updateReview(String reviewId, String newText, double newRating) async {
    try {
      await _reviewCollection.doc(reviewId).update({
        'text': newText,
        'rating': newRating,
        'date': Timestamp.fromDate(DateTime.now()), // 수정 시간 갱신
      });
      return true;
    } catch (e) {
      print("Error updating review: $e");
      return false;
    }
  }

  // ----------------------------------------
  // D. 삭제 (Delete)
  // ----------------------------------------
  Future<bool> deleteReview(String reviewId) async {
    try {
      await _reviewCollection.doc(reviewId).delete();
      return true;
    } catch (e) {
      print("Error deleting review: $e");
      return false;
    }
  }

  // ----------------------------------------
  // E. 신고 (Report)
  // ----------------------------------------
  Future<void> reportReview(String reviewId, String reporterUid) async {
    // 신고는 별도의 'reports' 컬렉션에 기록하는 것이 일반적입니다.
    await _firestore.collection('reports').add({
      'reviewId': reviewId,
      'reporterUid': reporterUid,
      'timestamp': FieldValue.serverTimestamp(),
      'status': 'pending',
    });
    print('Review $reviewId reported by $reporterUid');
  }
}