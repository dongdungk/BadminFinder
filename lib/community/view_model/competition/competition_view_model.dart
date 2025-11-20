import 'package:flutter/material.dart';
import '../../model/competition/competition_model.dart';
import '../../service/competition/competition_api_service.dart';

class CompetitionViewModel extends ChangeNotifier {
  final CompetitionApiService _api = CompetitionApiService();

  bool isLoading = false;
  String? errorMessage;

  List<CompetitionModel> competitions = [];
  CompetitionModel? selectedCompetition;

  Future<void> loadCompetitions() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final leagues = await _api.fetchBadmintonLeagues();
      if (leagues.isEmpty) throw Exception("리그 데이터를 불러올 수 없습니다.");

      final leagueId = leagues[0]["idLeague"].toString();

      final seasons = await _api.fetchSeasons(leagueId);
      if (seasons.isEmpty) throw Exception("시즌 데이터를 불러올 수 없습니다.");

      List<int> seasonYears = seasons
          .map((s) => int.tryParse(s["strSeason"].toString()) ?? 0)
          .where((year) => year > 0)
          .toList();

      if (seasonYears.isEmpty) {
        throw Exception("올바른 시즌 정보가 없습니다.");
      }

      seasonYears.sort((a, b) => b.compareTo(a));

      int latestSeason = seasonYears.first;

      print("📌 선택된 최신 시즌: $latestSeason");

      competitions = await _api.fetchEvents(leagueId, latestSeason.toString());

      if (competitions.isEmpty) {
        errorMessage = "$latestSeason 시즌의 대회 정보가 없습니다.";
      }

    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void selectCompetition(CompetitionModel c) {
    selectedCompetition = c;
  }

  Future<void> refresh() async {
    await loadCompetitions();
  }
}
