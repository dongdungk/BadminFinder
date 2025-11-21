// lib/map/service/photo_service.dart (새로 생성)

import 'package:cloud_firestore/cloud_firestore.dart';

class PhotoService {
  // Firestore 인스턴스는 한 번만 생성
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ⭐️ [핵심] 특정 시설의 이미지 URL 목록을 Firestore에서 가져옵니다.
  Future<List<String>> getPhotoUrls(String facilityId) async {
    try {
      // 'facility_photos' 컬렉션에서 시설 ID에 해당하는 문서를 찾음
      final doc = await _firestore
          .collection('facility_photos')
          .doc(facilityId) // 문서 ID가 시설 ID라고 가정
          .get();

      if (doc.exists && doc.data()!.containsKey('imageUrls')) {
        // 'imageUrls' 필드에서 URL 리스트를 가져와 List<String>으로 변환
        return List<String>.from(doc.data()!['imageUrls']);
      }

      return []; // 데이터가 없으면 빈 리스트 반환

    } catch (e) {
      print("Firestore Photo Service Error: $e");
      return [];
    }
  }

// (향후 사진 업로드/삭제 기능은 이 Service에 추가됩니다.)
}