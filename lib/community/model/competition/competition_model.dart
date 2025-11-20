class CompetitionModel {
  final String id;
  final String name;
  final String date;
  final String country;
  final String? thumb;
  final String? description;

  CompetitionModel({
    required this.id,
    required this.name,
    required this.date,
    required this.country,
    this.thumb,
    this.description,
  });

  factory CompetitionModel.fromJson(Map<String, dynamic> json) {
    return CompetitionModel(
      id: json["idEvent"] ?? "",
      name: json["strEvent"] ?? "이름 없음",
      date: json["dateEvent"] ?? "날짜 없음",
      country: json["strCountry"] ?? "국가 정보 없음",
      thumb: json["strThumb"],
      description: json["strDescriptionEN"],
    );
  }
}
