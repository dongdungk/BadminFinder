import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../model/competition/competition_model.dart';

class CompetitionApiService {
  static const String baseUrl = "https://www.thesportsdb.com/api/v1/json/3";

  Future<List<dynamic>> fetchBadmintonLeagues() async {
    final url = Uri.parse("$baseUrl/search_all_leagues.php?s=Badminton");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["countries"] ?? [];
    } else {
      throw Exception("Badminton league API error");
    }
  }

  Future<List<dynamic>> fetchSeasons(String leagueId) async {
    final url = Uri.parse("$baseUrl/search_all_seasons.php?id=$leagueId");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["seasons"] ?? [];
    } else {
      throw Exception("Season API error");
    }
  }

  Future<List<CompetitionModel>> fetchEvents(String leagueId, String season) async {
    final url = Uri.parse("$baseUrl/eventsseason.php?id=$leagueId&s=$season");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List events = data["events"] ?? [];

      return events
          .map((e) => CompetitionModel.fromJson(e))
          .toList();
    } else {
      throw Exception("Event API error");
    }
  }
}
