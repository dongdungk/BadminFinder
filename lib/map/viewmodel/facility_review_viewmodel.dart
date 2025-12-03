// lib/map/viewmodel/facility_review_viewmodel.dart

import 'package:flutter/material.dart';
import '../model/facility_review_model.dart';
import '../service/facility_review_service.dart';

class FacilityReviewViewModel extends ChangeNotifier {

  final ReviewService _reviewService;

  List<ReviewModel> _reviews = [];
  bool _isLoading = false;
  String _currentFacilityId = '';

  List<ReviewModel> get reviews => _reviews;
  bool get isLoading => _isLoading;

  FacilityReviewViewModel(this._reviewService);

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
}