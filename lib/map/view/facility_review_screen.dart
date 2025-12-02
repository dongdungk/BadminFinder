import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart'; // GoRouter 임포트
import '../viewmodel/facility_review_viewmodel.dart';
import '../model/facility_review_model.dart';
import '../view/facility_review_edit_screen.dart'; // 리뷰 수정 화면 임포트

// -------------------------------------------------------------
// RatingInput (별점 슬라이더)
// -------------------------------------------------------------
class RatingInput extends StatelessWidget {
  final double initialRating;
  final ValueChanged<double> onRatingChanged;

  const RatingInput({super.key, required this.initialRating, required this.onRatingChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.star, color: Colors.amber),
        Slider(
          value: initialRating,
          min: 0,
          max: 5,
          divisions: 10,
          onChanged: onRatingChanged,
        ),
        Text(initialRating.toStringAsFixed(1)),
      ],
    );
  }
}
// -------------------------------------------------------------


// -------------------------------------------------------------
// 1. ReviewWriteModal (리뷰 작성 폼) - 한글 입력 오류 수정 반영
// -------------------------------------------------------------
class ReviewWriteModal extends StatefulWidget {
  final FacilityReviewViewModel viewModel;
  final String facilityId;

  const ReviewWriteModal({super.key, required this.viewModel, required this.facilityId});

  @override
  State<ReviewWriteModal> createState() => _ReviewWriteModalState();
}

class _ReviewWriteModalState extends State<ReviewWriteModal> {
  final _textController = TextEditingController();
  final _nameController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode(); // ⭐️ FocusNode 추가
  double _currentRating = 5.0;

  @override
  void initState() {
    super.initState();
    // ⭐️ 화면이 그려진 후 이름 입력 필드에 포커스 강제 지정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _nameFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _nameController.dispose();
    _nameFocusNode.dispose(); // ⭐️ FocusNode dispose
    super.dispose();
  }

  void _submitReview() async {
    final text = _textController.text.trim();
    final userName = _nameController.text.trim();

    // 유효성 검사: 이름 또는 리뷰 내용이 비어있으면 경고
    if (text.isEmpty || userName.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(text.isEmpty ? '리뷰 내용을 입력해주세요.' : '이름을 입력해주세요.')),
      );
      return;
    }

    final success = await widget.viewModel.submitReview(
      rating: _currentRating,
      text: text,
      userName: userName,
    );

    if (success && mounted) {
      Navigator.of(context).pop();
    } else if (!success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('리뷰 저장에 실패했습니다.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // ⭐️⭐️⭐️ Scaffold로 감싸서 키보드 포커스 문제를 해결 ⭐️⭐️⭐️
    return Scaffold(
      appBar: AppBar(
        title: const Text('새 리뷰 작성'),
        automaticallyImplyLeading: false, // 모달에서는 보통 뒤로가기 버튼 제거
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ⭐️ 이름 입력 필드에 FocusNode 연결
            TextField(
              controller: _nameController,
              focusNode: _nameFocusNode,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '이름을 입력해주세요.',
              ),
            ),
            const SizedBox(height: 16),

            RatingInput(
              initialRating: _currentRating,
              onRatingChanged: (newRating) {
                setState(() {
                  _currentRating = newRating;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _textController,
              maxLines: 4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '시설에 대한 리뷰를 작성해주세요.',
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('취소'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _submitReview,
                  child: const Text('저장'),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
// -------------------------------------------------------------


// -------------------------------------------------------------
// 2. FacilityReviewScreen (메인 화면 위젯)
// -------------------------------------------------------------
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

  void _showWriteReviewModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true, // ⭐️ 포커스 문제를 위해 root navigator 사용 강제
      builder: (context) {
        final reviewVM = Provider.of<FacilityReviewViewModel>(context, listen: false);
        // 모달 높이 확보
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: ReviewWriteModal(viewModel: reviewVM, facilityId: widget.facilityId),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

          // ... (평균 별점 및 통계 계산 로직 유지) ...

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. 별점 통계 섹션 (생략)
                // ...
                const Divider(height: 1, thickness: 1),

                // 2. 리뷰 목록
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: reviewVM.reviews.length,
                  itemBuilder: (context, index) {
                    final review = reviewVM.reviews[index];
                    return ReviewListItem(
                      review: review,
                      viewModel: reviewVM,
                      currentUserId: reviewVM.currentUserId,
                      facilityId: widget.facilityId,
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showWriteReviewModal(context),
        child: const Icon(Icons.rate_review_outlined),
      ),
    );
  }
}
// -------------------------------------------------------------


// -------------------------------------------------------------
// 3. ReviewListItem (리뷰 목록 아이템 위젯)
// -------------------------------------------------------------
class ReviewListItem extends StatelessWidget {
  final ReviewModel review;
  final FacilityReviewViewModel viewModel;
  final String? currentUserId;
  final String facilityId;

  const ReviewListItem({
    super.key,
    required this.review,
    required this.viewModel,
    required this.currentUserId,
    required this.facilityId,
  });

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 1. 수정 & 삭제 (본인 리뷰일 경우에만 표시)
            if (review.userId == currentUserId) ...[
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('리뷰 수정'),
                onTap: () {
                  Navigator.pop(context);
                  // GoRouter로 수정 화면 이동
                  context.go(
                    // /facility/:id/reviews/edit/:reviewId
                    '/facility/$facilityId/reviews/edit/${review.reviewId}',
                    extra: review,
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_forever, color: Colors.red),
                title: const Text('리뷰 삭제'),
                onTap: () async {
                  await viewModel.deleteReview(review.reviewId);
                  Navigator.pop(context);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('리뷰가 삭제되었습니다.')),
                    );
                  }
                },
              ),
            ],

            // 2. 신고 (타인의 리뷰일 경우에만 표시)
            if (review.userId != currentUserId)
              ListTile(
                leading: const Icon(Icons.flag_outlined),
                title: const Text('리뷰 신고하기'),
                onTap: () async {
                  await viewModel.reportReview(review.reviewId);
                  Navigator.pop(context);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('리뷰가 신고되었습니다. 검토 후 처리됩니다.')),
                    );
                  }
                },
              ),

            ListTile(
              title: const Text('닫기'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(review.userName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        IconButton(
                          icon: const Icon(Icons.more_vert, size: 18, color: Colors.grey),
                          onPressed: () => _showOptions(context),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(review.rating.toStringAsFixed(1), style: const TextStyle(fontSize: 14, color: Colors.amber)),
                        const SizedBox(width: 8),
                        Text(review.date.toString().substring(0, 10), style: const TextStyle(fontSize: 13, color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // 리뷰 텍스트 표시
          Text(
            review.text,
            style: const TextStyle(fontSize: 14),
          ),
          const Divider(height: 24, thickness: 0.5),
        ],
      ),
    );
  }
}