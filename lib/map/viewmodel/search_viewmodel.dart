import 'package:flutter/material.dart';
import '/map/model/facility_model.dart'; // Model 임포트
import '/map/service/facility_service.dart'; // Service 임포트

// "검색 뇌" (로직과 상태 관리)
// ChangeNotifier는 '신호' (notifyListeners)를 보내기 위해 필요
class SearchViewModel extends ChangeNotifier {

  // 1. '뇌'는 '손발'(Service)이 필요함
  final FacilityService _facilityService;

  // 2. '뇌'가 관리할 '상태'(데이터)
  List<FacilityModel> _facilities = []; // '검색 결과' 데이터 (초기값: 비어있음)
  bool _isLoading = false;             // '로딩 중' 상태 (초기값: false)

  // 3. 'View'가 접근할 수 있도록 '상태'를 노출
  List<FacilityModel> get facilities => _facilities;
  bool get isLoading => _isLoading;

  // 4. 생성자 (main.dart에서 Service를 '주입'받음)
  SearchViewModel(this._facilityService);

  // 5. 'View'가 호출할 '로직'(기능)
  Future<void> searchFacilities(String query) async {
    // (쿼리가 비어있으면 검색 안 함)
    if (query.isEmpty) {
      _facilities = [];
      notifyListeners();
      return;
    }

    // 5-1. 로딩 시작
    _isLoading = true;
    _facilities = []; // (이전 검색 결과 초기화)
    notifyListeners(); // "나 로딩 시작했어!"라고 View에 '신호'

    // 5-2. '손발'(Service)에게 일 시키기
    try {
      // Service가 Mock 데이터가 아닌 "진짜 API"를 호출할 것임!
      _facilities = await _facilityService.searchFacilities(query);
    } catch (e) {
      // (에러 처리)
      print("ViewModel Error: $e");
      _facilities = [];
    }

    // 5-3. 로딩 끝
    _isLoading = false;
    notifyListeners(); // "나 일 끝났어! (데이터 갱신했어)"라고 View에 '신호'
  }
}