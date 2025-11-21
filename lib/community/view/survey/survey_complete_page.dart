import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../view_model/survey/survey_view_model.dart';

class SurveyCompletePage extends StatelessWidget {
  const SurveyCompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SurveyViewModel>();
    final survey = viewModel.selectedSurvey!;

    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              //체크 동그라미
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.green,
                    width: 5,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 65,
                  ),
                ),
              ),

              const SizedBox(height: 28),

              //투표 완료
              const Text(
                "투표 완료!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "소중한 의견 감사합니다.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 14),

              //총 참여 인원
              Text(
                "현재 ${survey.participants}명 참여 중",
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black38,
                ),
              ),

              const SizedBox(height: 40),

              //결과 보기 버튼
              GestureDetector(
                onTap: () {
                  context.go('/community/survey/result');
                },
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    "결과 보기",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              //확인 버튼
              GestureDetector(
                onTap: () {
                  context.go('/community/survey');
                },
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xFFEDEDED),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    "확인",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
