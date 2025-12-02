// lib/map/view/review_edit_screen.dart (최종 정리)

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/facility_review_model.dart';
import '../viewmodel/facility_review_viewmodel.dart';

// ⭐️ 별점 선택을 위한 위젯
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

// ⭐️ ReviewEditScreen 위젯
class ReviewEditScreen extends StatefulWidget {
  final String reviewId; // 라우터 경로에서 받은 ID
  final ReviewModel reviewToEdit; // 라우터 extra에서 받은 리뷰 객체

  const ReviewEditScreen({
    super.key,
    required this.reviewId,
    required this.reviewToEdit // 💡 reviewToEdit으로 이름 통일
  });

  @override
  _ReviewEditScreenState createState() => _ReviewEditScreenState();
}

class _ReviewEditScreenState extends State<ReviewEditScreen> {
  late TextEditingController _textController;
  late double _currentRating;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.reviewToEdit.text);
    _currentRating = widget.reviewToEdit.rating;
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _saveChanges() async {
    final newText = _textController.text.trim();
    if (newText.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('내용을 입력해주세요.')),
      );
      return;
    }

    // ⭐️ ViewModel을 Provider.of로 가져와서 updateReview 호출
    final viewModel = Provider.of<FacilityReviewViewModel>(context, listen: false);

    await viewModel.updateReview(
      widget.reviewToEdit.reviewId, // reviewToEdit 객체의 ID 사용
      newText,
      _currentRating,
    );

    if (!mounted) return;
    Navigator.of(context).pop(); // 팝업 닫기
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('리뷰 수정'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ... (UI 유지)
            // 별점 입력
            RatingInput(
              initialRating: _currentRating,
              onRatingChanged: (newRating) {
                setState(() {
                  _currentRating = newRating;
                });
              },
            ),
            const SizedBox(height: 16),
            // 텍스트 입력
            TextField(
              controller: _textController,
              maxLines: 4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '리뷰 내용을 수정하세요.',
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
                  onPressed: _saveChanges,
                  child: const Text('저장'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}