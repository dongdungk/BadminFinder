import 'package:flutter/material.dart';

class FacilityReviewScreen extends StatelessWidget {
  const FacilityReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('리뷰 (32)'), // 임시 타이틀
      ),
      body: ListView.builder(
        itemCount: 5, // 임시로 5개 리뷰
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. 프로필 + 별점
                  Row(
                    children: [
                      const CircleAvatar(child: Icon(Icons.person)),
                      const SizedBox(width: 8),
                      const Text('사용자 이름', style: TextStyle(fontWeight: FontWeight.bold)),
                      const Spacer(),
                      // 임시 별점
                      Row(
                        children: List.generate(
                          5,
                              (i) => Icon(
                            i < 4 ? Icons.star : Icons.star_border, // 4점
                            color: Colors.amber,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // 2. 리뷰 텍스트
                  Text(
                    '리뷰 내용입니다. ${index + 1}번째 리뷰입니다. 시설이 깨끗하고 좋았어요.',
                    style: const TextStyle(fontSize: 15),
                  ),
                  // 3. (선택) 리뷰 사진
                  // TODO: 리뷰에 사진이 있다면 여기에 표시
                ],
              ),
            ),
          );
        },
      ),
      // TODO: 프로토타입의 '리뷰 남기기' 버튼
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: const Icon(Icons.edit),
      // ),
    );
  }
}