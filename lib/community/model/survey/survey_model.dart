class SurveyOption {
  String title;
  int votes;

  SurveyOption({
    required this.title,
    this.votes = 0,
  });
}

class SurveyModel {
  String id;
  String question;
  List<SurveyOption> options;
  int participants; // 참여자 수
  bool isVoted;

  SurveyModel({
    required this.id,
    required this.question,
    required this.options,
    this.participants = 0,
    this.isVoted = false,
  });
}

