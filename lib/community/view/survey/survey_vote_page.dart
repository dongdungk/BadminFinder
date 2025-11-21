import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../model/survey/survey_model.dart';
import '../../view_model/survey/survey_view_model.dart';

class SurveyVotePage extends StatefulWidget {
  @override
  State<SurveyVotePage> createState() => _SurveyVotePageState();
}

class _SurveyVotePageState extends State<SurveyVotePage> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SurveyViewModel>();
    final SurveyModel survey = viewModel.selectedSurvey!;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black),

        title: Expanded(
          child: Text(
            survey.question,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.visible,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "가장 선호하는 배드민턴 라켓 브랜드는?",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            ...List.generate(survey.options.length, (idx) {
              final option = survey.options[idx];

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = idx;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 14,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selectedIndex == idx
                          ? Colors.blue
                          : Colors.grey.shade300,
                      width: selectedIndex == idx ? 2 : 1,
                    ),
                  ),

                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: selectedIndex == idx
                                ? Colors.blue
                                : Colors.grey,
                            width: 2,
                          ),
                        ),
                        child: selectedIndex == idx
                            ? Center(
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                          ),
                        )
                            : null,
                      ),

                      const SizedBox(width: 12),

                      Text(
                        option.title,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              );
            }),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: selectedIndex == null
                    ? null
                    : () {
                  viewModel.vote(survey.id, selectedIndex!);

                  context.go('/community/survey/complete');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  selectedIndex == null ? Colors.grey : Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "투표하기",
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
