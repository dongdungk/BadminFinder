// "붕어빵 틀" (데이터 설계도)
class FacilityModel {
  final String id; // (API에 ID가 없어서 '상호+주소'로 임의 생성)
  final String name;
  final String address;
  final String phone;
  final String category; // (API의 '업종'에 해당)

  // (이하 정보는 '동작구 API'에 없으므로, 기본값/계산이 필요합니다)
  final String distance;
  final String hours;
  final String price;
  final String reservation;
  final String status;
  final double rating;
  final int reviewCount;
  final List<String> images;

  // ⭐️ 1. [수정] 피드백 반영을 위한 필드 2개 추가
  final int currentOccupancy; // 현재 인원
  final int maxCapacity; // 최대 정원

  FacilityModel({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.category,

    // (기본값)
    this.distance = 'N/A',
    this.hours = '정보 없음',
    this.price = '정보 없음',
    this.reservation = '문의 필요',
    this.status = '정보 없음',
    this.rating = 0.0,
    this.reviewCount = 0,
    // ⭐️ 2. [수정] images의 기본값을 비어있는 리스트로 변경
    this.images = const [],
    // ⭐️ 3. [수정] 새로 추가된 필드의 기본값 설정
    this.currentOccupancy = 0, // 기본값 0명
    this.maxCapacity = 0, // 기본값 0명
  });

  // ---!!! [핵심] 님이 찾으신 "진짜 JSON 이름표"로 Model을 변환하는 공장 !!!---
  // (API 4개가 모두 이 '이름표'를 쓴다고 가정합니다)
  factory FacilityModel.fromJson(Map<String, dynamic> json) {

    // API에서 받은 '상호'와 '시설주소' (null일 수 있으므로 ?? '...' 처리)
    String name = json['상호'] as String? ?? '이름 없음';
    String address = json['시설주소'] as String? ?? '주소 정보 없음';

    return FacilityModel(
      // 1. '동작구 API'는 '시설 ID'가 없으므로, "상호+주소"를 조합해 고유 ID를 만듭니다.
      id: '$name-$address',

      // 2. 님이 찾으신 "JSON 이름표" (한글)를 정확히 입력합니다.
      name: name,
      address: address,
      phone: json['시설전화번호'] as String? ?? '전화번호 없음',
      category: json['업종'] as String? ?? '업종 정보 없음',

      // 3. (참고) 님이 찾은 '동작구 API'는 평점, 운영시간, 가격 등의 정보가
      //    '없습니다'. 따라서 이 값들은 '기본값'으로 들어가게 됩니다.

      // ⭐️ 4. [수정] 만약 API JSON에 이 필드들이 있다면 여기서 파싱합니다.
      //    (지금은 없으므로, 위 3번의 기본값(0)이 사용됩니다.)
      // currentOccupancy: json['현재인원'] as int? ?? 0,
      // maxCapacity: json['정원'] as int? ?? 0,
    );
  }
}