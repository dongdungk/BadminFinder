// lib/map/service/facility_review_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/facility_review_model.dart';

class ReviewService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ReviewModel>> getReviews(String facilityId) async {
    try {
      final snapshot = await _firestore
          .collection('reviews')
          .where('facilityId', isEqualTo: facilityId)
          .orderBy('date', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => ReviewModel.fromFirestore(doc.data() as Map<String, dynamic>))
          .toList();

    } catch (e) {
      print("Firestore Reviews Error: $e");
      return [];
    }
  }
}