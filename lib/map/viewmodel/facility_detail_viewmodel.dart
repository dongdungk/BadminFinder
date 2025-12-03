// lib/map/viewmodel/facility_detail_viewmodel.dart

import 'package:flutter/material.dart';
import '/map/service/facility_review_service.dart';
import '../model/facility_model.dart';
import '../service/facility_service.dart';
import '../service/facility_photo_service.dart'; // ⭐️ PhotoService 추가

class FacilityDetailViewModel extends ChangeNotifier {

  final FacilityService _facilityService;
  final PhotoService _photoService; // ⭐️ PhotoService 필드 추가

  FacilityModel? _facility;
  bool _isLoading = false;

  FacilityModel? get facility => _facility;
  bool get isLoading => _isLoading;

  // ⭐️ [수정] 생성자가 FacilityService와 PhotoService 두 개를 모두 주입받음
  FacilityDetailViewModel(this._facilityService, this._photoService, ReviewService reviewService);

  // ⭐️ [수정] loadFacility 함수에서 사진도 함께 로드합니다.
  Future<void> loadFacility(String facilityId) async {
    _isLoading = true;
    _facility = null;
    notifyListeners();

    try {
      // 1. 공공 API에서 시설 정보 로드
      final facilityDataFuture = _facilityService.getFacilityDetail(facilityId);

      // 2. ⭐️ Firestore에서 이미지 URL 로드
      final photoUrlsFuture = _photoService.getPhotos(facilityId);

      // 두 비동기 작업을 동시에 기다립니다.
      final results = await Future.wait([facilityDataFuture, photoUrlsFuture]);
      final FacilityModel? facilityData = results[0] as FacilityModel?;
      final List<String> photoUrls = results[1] as List<String>;

      // 3. ⭐️ [합병] FacilityModel에 이미지 리스트를 넣어줍니다.
      if (facilityData != null) {
        // (주의: FacilityModel에 copyWith 메서드가 없으므로,
        //  새로운 Model 객체를 생성하여 이미지 리스트를 넣어주는 방식으로 대체)
        _facility = FacilityModel(
          id: facilityData.id,
          name: facilityData.name,
          address: facilityData.address,
          phone: facilityData.phone,
          category: facilityData.category,

          // ⭐️ 로드된 사진 리스트를 images 필드에 할당
          images: photoUrls,

          // 나머지 필드는 기존 데이터 유지
          hours: facilityData.hours, price: facilityData.price,
          status: facilityData.status, reservation: facilityData.reservation,
          district: facilityData.district, rating: facilityData.rating,
          reviewCount: facilityData.reviewCount, distance: facilityData.distance,
          currentOccupancy: facilityData.currentOccupancy, maxCapacity: facilityData.maxCapacity,
        );
      } else {
        _facility = null;
      }

    } catch (e) {
      print("DetailViewModel Load Error: $e");
      _facility = null;
    }

    _isLoading = false;
    notifyListeners();
  }
}