// 커뮤니티 - 설문조사 - view ui
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../view_model/survey/survey_view_model.dart';
import '../../model/survey/survey_model.dart';
import '../community_top_tabs.dart';

class SurveyPage extends StatelessWidget {
  const SurveyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SurveyViewModel>();
    final surveys = viewModel.surveys;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 22),
          const CommunityTopTabs(),
          const SizedBox(height: 8),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: surveys.length,
              itemBuilder: (context, index) {
                final survey = surveys[index];

                return Column(
                  children: [
                    _SurveyCard(survey: survey),
                    const SizedBox(height: 12),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SurveyCard extends StatelessWidget {
  final SurveyModel survey;

  const _SurveyCard({required this.survey});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SurveyViewModel>();

    if (survey.isVoted) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green.shade100),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.check_circle_outline, color: Colors.green, size: 20),
                SizedBox(width: 6),
                Text(
                  '참여완료된 설문',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              survey.question,
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 8),

            GestureDetector(
              onTap: () {
                viewModel.selectSurvey(survey);
                context.push('/community/survey/result');
              },
              child: Container(
                height: 36,
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green.shade200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '결과 보기',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue.shade100),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.poll_outlined, color: Colors.blue, size: 20),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  survey.question,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          Row(
            children: [
              const Icon(Icons.people_outline, color: Colors.grey, size: 16),
              const SizedBox(width: 4),
              Text(
                "${survey.participants}명 참여",
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            height: 38,
            child: ElevatedButton(
              onPressed: survey.isVoted
                  ? null
                  : () {
                viewModel.selectSurvey(survey);
                context.push("/community/survey/vote");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                survey.isVoted ? Colors.grey : Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                survey.isVoted ? "참여완료" : "참여하기",
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
