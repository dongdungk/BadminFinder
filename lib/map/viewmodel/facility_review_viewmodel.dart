// lib/map/viewmodel/facility_review_viewmodel.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // UID를 위해 필요
import '../model/facility_review_model.dart';
import '../service/facility_review_service.dart';

class FacilityReviewViewModel extends ChangeNotifier {

  // ⭐️ [DI] ReviewService를 주입받음
  final ReviewService _reviewService;

  // 1. 상태 변수 정의
  List<ReviewModel> _reviews = [];
  bool _isLoading = false;
  String _currentFacilityId = '';

  // 2. Getter 정의 (UI 접근용)
  List<ReviewModel> get reviews => _reviews;
  bool get isLoading => _isLoading;
  String? get currentUserId => FirebaseAuth.instance.currentUser?.uid; // 현재 로그인된 UID

  // 3. 생성자 (DI)
  FacilityReviewViewModel(this._reviewService);

  // ----------------------------------------
  // A. 읽기 (Read - loadReviews)
  // ----------------------------------------
  Future<void> loadReviews(String facilityId) async {
    _currentFacilityId = facilityId;

    _isLoading = true;
    notifyListeners();

    try {
      _reviews = await _reviewService.getReviews(facilityId);
    } catch (e) {
      print("ReviewViewModel Load Error: $e");
      _reviews = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  // ----------------------------------------
  // B. 쓰기/생성 (Create - submitReview)
  // ----------------------------------------
  Future<bool> submitReview({
    required double rating,
    required String text,
    required String userName,
  }) async {
    final uid = currentUserId;
    if (uid == null) return false; // 1. 로그인되어 있지 않으면 실패 처리

    // ⭐️ [FIX] ReviewModel의 필수 인자 (reviewId, userId) 추가
    final newReview = ReviewModel(
      facilityId: _currentFacilityId,
      userName: userName,
      rating: rating,
      text: text,
      date: DateTime.now(),
      reviewId: '', // Firestore가 ID를 자동 생성하므로, 빈 문자열로 초기화
      userId: uid, // 현재 로그인된 사용자 UID 저장
    );

    _isLoading = true;
    notifyListeners();

    // 2. Service 호출
    final success = await _reviewService.addReview(newReview);

    _isLoading = false;
    if (success) {
      await loadReviews(_currentFacilityId); // 저장 성공 시 목록 새로고침
    }

    notifyListeners(); // 로딩 상태 해제 및 실패 시 화면 업데이트
    return success;
  }

  // ----------------------------------------
  // C. 수정 및 삭제 (Update & Delete)
  // ----------------------------------------
  Future<void> deleteReview(String reviewId) async {
    await _reviewService.deleteReview(reviewId);
    await loadReviews(_currentFacilityId); // 삭제 후 새로고침
  }

  Future<void> updateReview(String reviewId, String newText, double newRating) async {
    await _reviewService.updateReview(reviewId, newText, newRating);
    await loadReviews(_currentFacilityId); // 수정 후 새로고침
  }

  // ----------------------------------------
  // D. 신고 (Report)
  // ----------------------------------------
  Future<void> reportReview(String reviewId) async {
    final uid = currentUserId;
    if (uid == null) return;

    await _reviewService.reportReview(reviewId, uid);
    print("Review $reviewId successfully reported.");
  }
}