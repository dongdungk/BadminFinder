import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../model/facility_model.dart';

class FacilityService {
  final String _seoulBaseUrl = 'http://openAPI.seoul.go.kr:8088';
  final String _serviceName = 'facilities';

  // 영어 검색어를 한글 자치구명으로 변환하는 맵은 필수입니다.
  // 이 맵의 '값(Values)'은 지역구 이름 식별에 사용됩니다.
  final Map<String, String> _queryAliases = {
    'songpa': '송파', 'gwangjin': '광진', 'seongbuk': '성북', 'dongjak': '동작',
    'gangseo': '강서', 'gangnam': '강남', 'seocho': '서초', 'mapo': '마포',
    'yeongdeungpo': '영등포', 'yongsan': '용산', 'eunpyeong': '은평',
    'jongno': '종로', 'jung': '중구', 'junggu': '중구', 'jungnang': '중랑',
    'dobong': '도봉', 'nowon': '노원', 'guro': '구로', 'geumcheon': '금천',
    'gwanak': '관악', 'gangdong': '강동', 'gangbuk': '강북',
    'yangcheon': '양천', 'seongdong': '성동', 'seodaemun': '서대문',
  };

  Future<List<FacilityModel>> searchFacilities(String query) async {
    String processedQuery = query.toLowerCase().trim();

    // 1. 영어 별칭 변환 시도 (searchKeyword는 변환된 한글 자치구명, 또는 원본 쿼리)
    String searchKeyword = _queryAliases[processedQuery] ?? processedQuery;

    final String? serviceKey = dotenv.env['SEOUL_API_KEY'];
    if (serviceKey == null) return [];

    final Uri url = Uri.parse(
        '$_seoulBaseUrl/$serviceKey/json/$_serviceName/1/1000/'
    );

    print('Calling Seoul API: $url');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> body =
        jsonDecode(utf8.decode(response.bodyBytes));

        List<dynamic> dataList = [];
        if (body.containsKey(_serviceName)) {
          dataList = body[_serviceName]['row'];
        } else if (body.containsKey('DATA')) {
          dataList = body['DATA'];
        }

        // ⭐️⭐️⭐️ [최종 필터링 로직: 전략 분리] ⭐️⭐️⭐️
        List<FacilityModel> facilities = dataList
            .map((jsonItem) => FacilityModel.fromJson(jsonItem))
            .where((facility) {

          // 1. 배드민턴 시설만 골라내기 (필수)
          bool isBadminton = facility.category.contains('배드민턴') ||
              facility.name.contains('배드민턴');

          // 2. 검색어 일치 여부 확인 (지역구 또는 시설명)
          bool isMatch = false;

          if (searchKeyword.isEmpty) {
            isMatch = true; // 검색어가 없으면 모든 배드민턴 시설 통과
          } else {
            String normalizedSearch = searchKeyword.toLowerCase();

            // 💡 1. 검색어가 지역구 이름인지 확인 (Alias 맵의 값 목록 사용)
            bool isDistrictName = _queryAliases.values.contains(normalizedSearch);

            // ⭐️ 2. 검색 전략 분리 실행
            if (isDistrictName) {
              // A. '강남', '송파' 등 지역구 이름과 일치하면, 지역구 필터만 실행
              // -> 강남구 시설만 나오도록 강제
              isMatch = facility.district.toLowerCase().contains(normalizedSearch);
            } else {
              // B. '월곡', '스타일' 등 지역구 이름이 아닌 경우, 시설 이름 필터만 실행
              isMatch = facility.name.toLowerCase().contains(normalizedSearch);
            }
          }

          // 최종 반환: 배드민턴 시설이면서 검색 조건(지역/이름)에 맞아야 함
          return isBadminton && isMatch;
        })
            .toList();

        print('✅ Found ${facilities.length} badminton courts matching "$searchKeyword"');
        return facilities;

      } else {
        print('API 서버 에러: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('네트워크/파싱 에러: $e');
      return [];
    }
  }

  Future<FacilityModel?> getFacilityDetail(String facilityName) async {
    // 상세 검색은 전체 목록에서 이름으로 찾습니다.
    List<FacilityModel> allFacilities = await searchFacilities("");
    try {
      return allFacilities.firstWhere(
              (facility) => facility.name.contains(facilityName)
      );
    } catch (e) {
      return null;
    }
  }
}