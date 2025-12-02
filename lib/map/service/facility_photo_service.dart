// lib/map/service/facility_photo_service.dart (수정됨)

import 'package:cloud_firestore/cloud_firestore.dart';

class PhotoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // [핵심 기능] 특정 시설의 사진 URL 목록을 Firestore에서 가져옵니다.
  Future<List<String>> getPhotos(String facilityId) async {
    try {
      // 'photos' 컬렉션에서 해당 시설 ID의 문서를 찾습니다.
      final snapshot = await _firestore
          .collection('facility_photos') // 💡 컬렉션 이름도 'facility_photos'로 정확히 지정
          .where('facilityId', isEqualTo: facilityId)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        return [];
      }

      final data = snapshot.docs.first.data();

      // ⭐️⭐️⭐️ 수정: 필드 이름을 'urls'에서 'imageUrls'로 변경 ⭐️⭐️⭐️
      final List<dynamic>? imageUrls = data['imageUrls'] as List<dynamic>?;

      // List<dynamic>을 List<String>으로 변환하여 반환
      return imageUrls?.map((e) => e.toString()).toList() ?? [];

    } catch (e) {
      print("Firestore Photos Error: $e");
      return [];
    }
  }
}