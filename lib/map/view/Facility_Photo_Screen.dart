import 'package:flutter/material.dart'; // 'packagea:' -> 'package:'로 수정

class FacilityPhotoScreen extends StatelessWidget {
  const FacilityPhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('사진 (12)'), // 임시 타이틀
      ),
      // GridView로 사진 갤러리 구현
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 한 줄에 3개
          crossAxisSpacing: 8.0, // 가로 간격
          mainAxisSpacing: 8.0, // 세로 간격
        ),
        itemCount: 12, // 임시로 12개 사진
        itemBuilder: (context, index) {
          return Container(
            color: Colors.grey[300],
            alignment: Alignment.center,
            child: Text('사진 ${index + 1}'),
          );
        },
      ),
    );
  }
}