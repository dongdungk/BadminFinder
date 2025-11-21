import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../model/survey/survey_model.dart';
import '../../view_model/survey/survey_view_model.dart';
import 'vote_result_bar.dart';

class SurveyResultPage extends StatelessWidget {
  const SurveyResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SurveyViewModel>();
    final SurveyModel survey = viewModel.selectedSurvey!;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text(
          "투표 결과",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                survey.question,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "총 ${survey.participants}명 참여",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 28),

              ...List.generate(survey.options.length, (index) {
                final option = survey.options[index];
                final percent = viewModel.getPercentage(survey.id, index);

                final barColor = [
                  Colors.blue,
                  Colors.green,
                  Colors.orange,
                  Colors.grey,
                ][index % 4];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 22),
                  child: VoteResultBar(
                    title: option.title,
                    percent: percent,
                    votes: option.votes,
                    color: barColor,
                  ),
                );
              }),

              const SizedBox(height: 40),

              GestureDetector(
                onTap: () {
                  context.go('/community/survey');
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,

                  child: const Text(
                    "홈",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
