import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsApiService {
  static const String baseUrl = "https://gnews.io/api/v4";
  static const String apiKey = "60a75e020e9a93a656ef6d57ceea01ae";

  Future<List<dynamic>> fetchBadmintonNews() async {
    final url = Uri.parse(
        "$baseUrl/search"
            "?q=badminton OR BWF OR shuttlecock OR racket"
            "&lang=en"
            "&max=20"
            "&apikey=$apiKey"
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json["articles"] ?? [];
    } else {
      throw Exception("GNews API 오류: ${response.statusCode}");
    }
  }
}
