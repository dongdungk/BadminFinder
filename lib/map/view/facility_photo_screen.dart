// ⭐️ 1. [수정 완료] 'package://' 오타를 'package:'로 수정
import 'package:flutter/material.dart';

class FacilityPhotoScreen extends StatefulWidget {
  // facilityId를 받기 위한 변수 추가
  final String facilityId;

  // 생성자 수정 (facilityId 추가)
  const FacilityPhotoScreen({
    super.key,
    required this.facilityId,
  });

  @override
  State<FacilityPhotoScreen> createState() => _FacilityPhotoScreenState();
}

class _FacilityPhotoScreenState extends State<FacilityPhotoScreen> {
  int _selectedChipIndex = 0; // '전체' 칩이 기본 선택

  // ---!!! [신규] 님이 assets에 추가하신 12개의 이미지 리스트 !!!---
  final List<String> photoAssets = [
    "assets/download.jpg",
    "assets/download1.jpg",
    "assets/images.jpg",
    "assets/images (1).jpg",
    "assets/images (2).jpg",
    "assets/images (3).jpg",
    "assets/images (4).jpg",
    "assets/images (5).jpg",
    "assets/AKR20240416124700060_01_i_P4.jpg",
    "assets/AKR20240416124700060_01_i_P4.jpg",
    "assets/cts5395_img07.jpg",
    "assets/img_yongwang.jpg"
  ];

  final List<String> filterChips = [
    '전체',
    '클립',
    '방문자',
    '블로그',
    '인스타'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('사진 (ID: ${widget.facilityId})'), // (임시) 시설 이름
        actions: [
          IconButton(
            icon: const Icon(Icons.star_border), // 즐겨찾기 전
            onPressed: () {
              // TODO: 즐겨찾기 추가/삭제 로직
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildUploadBanner(),
          _buildFilterChips(),
          GridView.builder(
            padding: const EdgeInsets.all(8.0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: photoAssets.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  photoAssets[index],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      alignment: Alignment.center,
                      child: const Icon(Icons.error_outline, color: Colors.grey),
                    );
                  },
                ),
              );
            },
          ),
          _buildShowMoreButton(),
        ],
      ),
    );
  }

  Widget _buildUploadBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.camera_alt_outlined, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  '사진 256장', // (임시)
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: 사진 올리기 기능
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                // ⭐️ 2. [수정 완료] Rorde -> Border 오타 수정
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text('사진 올리기'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: 60.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: filterChips.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ChoiceChip(
              label: Text(filterChips[index]),
              selected: _selectedChipIndex == index,
              onSelected: (bool selected) {
                setState(() {
                  _selectedChipIndex = selected ? index : -1;
                  // TODO: ViewModel을 통해 필터링 로직 수행
                });
              },
              selectedColor: Colors.blue,
              labelStyle: TextStyle(
                color: _selectedChipIndex == index ? Colors.white : Colors.black,
              ),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(
                  color: _selectedChipIndex == index
                      ? Colors.blue
                      : Colors.grey.shade300,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildShowMoreButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: OutlinedButton(
        onPressed: () {
          // TODO: 사진 더보기 (페이지네이션)
        },
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        child: const Text(
          '사진 더보기 (244장)', // (임시)
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}