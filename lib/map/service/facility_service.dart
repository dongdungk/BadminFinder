import 'dart:convert'; // 1. JSON 변환을 위해 'dart:convert' 임포트
import 'package:http/http.dart' as http; // 2. 'http' 패키지 임포트
import 'package:victor/map/model/facility_model.dart'; // 3. 붕어빵 틀(Model) 임포트

// "손과 발" (실제 외부 API/DB 통신)
class FacilityService {

  // ---!!! [핵심 수정] 님이 승인받은 "진짜" API 정보 !!!---
  final String _baseUrl = "https://api.odcloud.kr/api"; // 1. 님이 받은 Base URL
  final String _apiKey = "e6d62c5973164a3552572d4320463edccb6a11e7ef843f5c81f98b757c3a9edd"; // 2. 님이 받은 인증키

  // 3. 님이 찾은 4개의 API Endpoint 목록
  final Map<String, String> _apiEndpoints = {
    '광진': '/15015554/v1/uddi:f3d6dfbf-fdb9-402e-811b-fd72e4eed74d',
    '송파': '/15005433/v1/uddi:75702525-9c23-414e-b529-d9e61c814cba',
    '성북': '/15040336/v1/uddi:8879f548-577c-4558-9401-e7c9e9a1d13e',
    '동작': '/15016523/v1/uddi:0f19c236-7ae3-422b-95ff-c40b7b3e667c',
  };
  // -----------------------------------------------------------------


  // ViewModel이 호출할 '검색' 기능
  Future<List<FacilityModel>> searchFacilities(String query) async {

    // ---!!! [핵심 수정] 쿼리(query)를 소문자로 변경하고, 영어도 확인 !!!---
    String? districtKey;
    String lowercaseQuery = query.toLowerCase(); // 1. "Songpa" -> "songpa"

    if (lowercaseQuery.contains('광진') || lowercaseQuery.contains('gwangjin')) {
      districtKey = '광진';
    } else if (lowercaseQuery.contains('송파') || lowercaseQuery.contains('songpa')) { // 2. "songpa" (영어) 추가!
      districtKey = '송파';
    } else if (lowercaseQuery.contains('성북') || lowercaseQuery.contains('seongbuk')) {
      districtKey = '성북';
    } else if (lowercaseQuery.contains('동작') || lowercaseQuery.contains('dongjak')) {
      districtKey = '동작';
    } else {
      // (일치하는 지역구가 없으면 빈 리스트 반환)
      return [];
    }

    // 1. 님이 검색한 '지역구'에 맞는 Endpoint 주소를 가져옴
    final String? endpoint = _apiEndpoints[districtKey];
    if (endpoint == null) return [];

    // 2. 님이 검색한 '지역구'의 API를 호출!
    final response = await http.get(
      Uri.parse('$_baseUrl$endpoint?serviceKey=$_apiKey&page=1&perPage=100'),
    );

    if (response.statusCode == 200) {
      // 3. 성공!
      final Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));

      // 4. "data" 키 확인
      if (data.containsKey('data') && data['data'] is List) {

        final List<dynamic> facilityListJson = data['data'];

        // 5. 붕어빵 리스트로 찍어내기
        List<FacilityModel> facilities = facilityListJson.map((json) => FacilityModel.fromJson(json)).toList();

        // 6. (필터링) "송파 배드민턴"이라고 검색했다면, "배드민턴"만 필터링
        String filterQuery = lowercaseQuery.replaceAll(districtKey.toLowerCase(), '').trim();
        if (filterQuery.isNotEmpty) {
          facilities = facilities.where((facility) =>
          facility.name.toLowerCase().contains(filterQuery) ||
              facility.category.toLowerCase().contains(filterQuery)
          ).toList();
        }

        return facilities;

      } else {
        return [];
      }
    } else {
      // 7. 실패!
      print("Service Error: Failed to search facilities. Status: ${response.statusCode}");
      throw Exception('Failed to load facilities');
    }
  }


  // ViewModel이 호출할 '시설 상세' 기능 (이전과 동일)
  Future<FacilityModel> getFacilityDetail(String facilityId) async {
    await Future.delayed(const Duration(milliseconds: 100));

    final allFacilities = [
      ...await searchFacilities("광진"),
      ...await searchFacilities("송파"),
      ...await searchFacilities("성북"),
      ...await searchFacilities("동작"),
    ];

    try {
      return allFacilities.firstWhere((facility) => facility.id == facilityId);
    } catch (e) {
      print("Service Error: Failed to find detail for ID: $facilityId");
      throw Exception('Failed to load facility detail');
    }
  }
}