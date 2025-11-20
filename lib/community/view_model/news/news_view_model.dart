import 'package:flutter/material.dart';
import '../../model/news/news_model.dart';
import '../../service/news/news_api_service.dart';

class NewsViewModel extends ChangeNotifier {
  final NewsApiService _api = NewsApiService();

  bool isLoading = false;
  String? errorMessage;
  List<NewsModel> news = [];

  Future<void> loadNews() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final data = await _api.fetchBadmintonNews();
      news = data.map((e) => NewsModel.fromJson(e)).toList();
    } catch (e) {
      errorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
