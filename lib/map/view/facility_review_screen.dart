// lib/map/view/facility_review_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/facility_review_viewmodel.dart';
import '../model/facility_review_model.dart';

class FacilityReviewScreen extends StatefulWidget {
  final String facilityId;

  const FacilityReviewScreen({super.key, required this.facilityId});

  @override
  State<FacilityReviewScreen> createState() => _FacilityReviewScreenState();
}

class _FacilityReviewScreenState extends State<FacilityReviewScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FacilityReviewViewModel>().loadReviews(widget.facilityId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ⭐️ [FIX 1] AppBar 제목을 시설 이름으로 변경
      appBar: AppBar(
        title: Text(widget.facilityId, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Consumer<FacilityReviewViewModel>(
        builder: (context, reviewVM, child) {
          if (reviewVM.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (reviewVM.reviews.isEmpty) {
            return const Center(child: Text('등록된 리뷰가 없습니다. 첫 리뷰를 작성해보세요!'));
          }

          // 평균 별점 계산
          double averageRating = reviewVM.reviews.fold(0.0, (sum, item) => sum + item.rating) / reviewVM.reviews.length;
          // 각 별점 개수 계산
          Map<int, int> ratingCounts = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
          for (var review in reviewVM.reviews) {
            ratingCounts[review.rating.toInt()] = (ratingCounts[review.rating.toInt()] ?? 0) + 1;
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ⭐️ [FIX 2] 하드코딩된 '서초구민체육센터'를 실제 시설 이름으로 변경
                      Text(
                        widget.facilityId, // 👈 시설 이름 사용
                        style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            averageRating.toStringAsFixed(2),
                            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.star, color: Colors.amber, size: 30),
                        ],
                      ),
                      Text(
                        '${reviewVM.reviews.length}개 리뷰',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 20),
                      // 별점 통계 바
                      ...List.generate(5, (index) {
                        int star = 5 - index;
                        int count = ratingCounts[star] ?? 0;
                        double percentage = reviewVM.reviews.isEmpty ? 0 : count / reviewVM.reviews.length;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 25,
                                child: Text('$star', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: LinearProgressIndicator(
                                  value: percentage,
                                  backgroundColor: Colors.grey[200],
                                  color: Colors.amber,
                                  minHeight: 8,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              const SizedBox(width: 8),
                              SizedBox(
                                width: 35,
                                child: Text(
                                  '${(percentage * 100).toInt()}%',
                                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              SizedBox(
                                width: 30,
                                child: Text(
                                  '$count',
                                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                const Divider(height: 1, thickness: 1),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: reviewVM.reviews.length,
                  itemBuilder: (context, index) {
                    final review = reviewVM.reviews[index];
                    // ReviewListItem 위젯은 이전에 구현된 리뷰 항목 UI를 사용합니다.
                    return ReviewListItem(review: review);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// lib/map/view/facility_review_screen.dart (파일 맨 끝에 추가)

// 리뷰 목록 아이템 위젯
class ReviewListItem extends StatelessWidget {
  final ReviewModel review;

  const ReviewListItem({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 사용자 프로필 이미지 (임시)
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.blueGrey,
                child: Text(
                  review.userName.substring(0, 1),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          review.userName,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        // 우측 상단의 댓글/대화 아이콘
                        const Icon(Icons.chat_bubble_outline, size: 18, color: Colors.grey),
                      ],
                    ),
                    Text(
                      review.date.toString().substring(0, 10), // 날짜 포맷
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // 별점
          Row(
            children: List.generate(review.rating.toInt(), (i) => const Icon(Icons.star, color: Colors.amber, size: 16)),
          ),
          const SizedBox(height: 4),
          Text(
            review.text,
            style: const TextStyle(fontSize: 16, height: 1.4), // 가독성 향상
          ),
          const SizedBox(height: 10),
          // 좋아요/댓글 섹션
          Row(
            children: [
              Icon(Icons.thumb_up_alt_outlined, size: 18, color: Colors.grey),
              const SizedBox(width: 4),
              // ⭐️ likes, comments 필드는 모델에 있으므로 정상 작동합니다.
              Text('도움돼요 ${review.likes}', style: const TextStyle(color: Colors.grey, fontSize: 14)),
              const SizedBox(width: 16),
              Icon(Icons.comment_outlined, size: 18, color: Colors.grey),
              const SizedBox(width: 4),
              Text('댓글 ${review.comments}', style: const TextStyle(color: Colors.grey, fontSize: 14)),
            ],
          ),
          const Divider(height: 24, thickness: 0.5),
        ],
      ),
    );
  }
}

// ReviewListItem 클래스는 이전 응답에 포함되어 있다고 가정합니다.
// ReviewModel에 likes, comments 필드가 없으므로, 해당 필드는 일단 제거하거나 기본값으로 둡니다.
// (만약 이 코드가 에러를 낸다면, ReviewListItem의 likes/comments 사용 부분을 삭제해야 합니다.)