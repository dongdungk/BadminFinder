// lib/map/model/facility_review_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final String facilityId;
  final String userName;
  final double rating;
  final String text;
  final DateTime date;

  // ⭐️ UI에서 사용되는 필드 (좋아요/댓글 기능용)
  final int likes;
  final int comments;

  // ⭐️ [FIX] 수정/삭제/조회를 위한 리뷰 ID 필드 추가 (Service에서 문서 ID를 받음)
  final String reviewId;
  // ⭐️ [FIX] 작성자 UID (향후 수정/삭제 권한 확인용)
  final String userId;


  ReviewModel({
    required this.facilityId,
    required this.userName,
    required this.rating,
    required this.text,
    required this.date,
    required this.reviewId, // ⭐️ 생성자에 필수 필드로 추가
    required this.userId,   // ⭐️ 생성자에 필수 필드로 추가

    this.likes = 0,
    this.comments = 0,
  });

  // ⭐️ [FIX] Firestore 문서에서 ReviewModel 객체를 생성하는 Factory
  // docId: Firestore에서 문서 ID를 가져와 reviewId로 사용합니다.
  factory ReviewModel.fromFirestore(Map<String, dynamic> data, String docId) {

    final timestamp = data['date'] as Timestamp?;

    return ReviewModel(
      facilityId: data['facilityId'] as String? ?? '',
      userName: data['userName'] as String? ?? '익명 사용자',

      // ⭐️ [FIX] 사용자 ID를 저장 (수정/삭제 권한 확인용)
      userId: data['userId'] as String? ?? 'unknown',

      // Firestore는 숫자를 num으로 반환
      rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
      text: data['text'] as String? ?? '',
      date: timestamp?.toDate() ?? DateTime.now(),

      // ⭐️ [FIX] 문서 ID와 좋아요/댓글 필드 저장
      reviewId: docId,
      likes: (data['likes'] as num?)?.toInt() ?? 0,
      comments: (data['comments'] as num?)?.toInt() ?? 0,
    );
  }

  // ⭐️ [추가] Firestore에 데이터를 저장하기 위한 JSON 변환 메서드 (쓰기 기능용)
  Map<String, dynamic> toJson() {
    return {
      'facilityId': facilityId,
      'userName': userName,
      'rating': rating,
      'text': text,
      'date': Timestamp.fromDate(date),
      'userId': userId,
      'likes': likes,
      'comments': comments,
    };
  }
}