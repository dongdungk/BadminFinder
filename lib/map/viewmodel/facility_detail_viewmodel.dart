import 'package:flutter/material.dart';
import 'package:victor/map/model/facility_model.dart'; // Model 임포트
import 'package:victor/map/service/facility_service.dart'; // Service 임포트

// "시설 상세 화면"의 '뇌'
class FacilityDetailViewModel extends ChangeNotifier {

  final FacilityService _facilityService;

  // '뇌'가 관리할 '상태'(데이터)
  FacilityModel? _facility; // 상세 데이터 (처음엔 없음)
  bool _isLoading = false;   // 로딩 중 상태

  // 'View'가 접근할 수 있도록 '상태'를 노출
  FacilityModel? get facility => _facility;
  bool get isLoading => _isLoading;

  // 생성자 (main.dart에서 Service를 '주입'받음)
  FacilityDetailViewModel(this._facilityService);

  // 'View'가 호출할 '로직'(기능)
  Future<void> loadFacility(String facilityId) async {
    // 1. 로딩 시작
    _isLoading = true;
    _facility = null; // (이전 데이터 초기화)
    notifyListeners(); // "나 로딩 시작했어!"라고 View에 '신호'

    // 2. '손발'(Service)에게 일 시키기
    try {
      // Service가 "진짜 API"를 호출할 것임!
      _facility = await _facilityService.getFacilityDetail(facilityId);
    } catch (e) {
      print("DetailViewModel Error: $e");
      _facility = null;
    }

    // 3. 로딩 끝
    _isLoading = false;
    notifyListeners(); // "나 일 끝났어! (데이터 갱신했어)"라고 View에 '신호'
  }
}