// lib/map/model/facility_review_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final String facilityId;
  final String userName;
  final double rating;
  final String text;
  final DateTime date;

  // ⭐️ [FIX] UI에서 필요로 하는 likes와 comments 필드를 추가합니다.
  final int likes;
  final int comments;

  ReviewModel({
    required this.facilityId,
    required this.userName,
    required this.rating,
    required this.text,
    required this.date,

    // ⭐️ [FIX] 생성자에 기본값 설정 (Firestore에 데이터가 없을 경우 0으로 처리)
    this.likes = 0,
    this.comments = 0,
  });

  // ⭐️ [FIX] Firestore 문서에서 ReviewModel 객체를 생성하는 Factory
  factory ReviewModel.fromFirestore(Map<String, dynamic> data) {

    final timestamp = data['date'] as Timestamp?;

    return ReviewModel(
      facilityId: data['facilityId'] as String? ?? '',
      userName: data['userName'] as String? ?? '익명 사용자',
      // Firestore는 숫자를 num으로 반환하는 경우가 많으므로 toDouble()을 사용
      rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
      text: data['text'] as String? ?? '',
      date: timestamp?.toDate() ?? DateTime.now(),

      // ⭐️ [FIX] Firestore에서 likes와 comments를 가져오거나 0으로 설정합니다.
      likes: (data['likes'] as num?)?.toInt() ?? 0,
      comments: (data['comments'] as num?)?.toInt() ?? 0,
    );
  }
}