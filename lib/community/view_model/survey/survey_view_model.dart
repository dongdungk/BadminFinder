import 'package:flutter/material.dart';
import '../../model/survey/survey_model.dart';

class SurveyViewModel extends ChangeNotifier {
  final List<SurveyModel> _surveys = [];

  List<SurveyModel> get surveys => List.unmodifiable(_surveys);

  SurveyModel? _selectedSurvey;
  SurveyModel? get selectedSurvey => _selectedSurvey;

  void selectSurvey(SurveyModel survey) {
    _selectedSurvey = survey;
    notifyListeners();
  }

  //설문 데이터 초기화
  void loadSurvey() {
    if (_surveys.isNotEmpty) return;

    _surveys.add(
      SurveyModel(
        id: "1",
        question: "가장 좋아하는 배드민턴 브랜드는?",
        options: [
          SurveyOption(title: "요넥스"),
          SurveyOption(title: "비브라니움"),
          SurveyOption(title: "아스트로X"),
          SurveyOption(title: "윌슨"),
        ],
      ),
    );

    notifyListeners();
  }

  //특정 항목에 투표 + 참여자 증가 + 참여완료 처리
  void vote(String surveyId, int optionIndex) {
    final index = _surveys.indexWhere((s) => s.id == surveyId);
    if (index == -1) return;

    final survey = _surveys[index];

    if (survey.isVoted) return; // 🔥 이미 참여했으면 막기

    survey.participants++;
    survey.options[optionIndex].votes++;
    survey.isVoted = true; // 🔥 투표 완료 처리

    notifyListeners();
  }

  //퍼센트 계산
  int getPercentage(String surveyId, int optionIndex) {
    final survey =
    _surveys.firstWhere((s) => s.id == surveyId, orElse: () => _surveys[0]);

    final total = survey.participants;
    final votes = survey.options[optionIndex].votes;

    if (total == 0) return 0;

    return ((votes / total) * 100).round();
  }
}
