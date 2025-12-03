import 'package:flutter/material.dart' show AppBar, BorderRadius, BoxFit, BuildContext, ClipRRect, Colors, Column, CrossAxisAlignment, EdgeInsets, ElevatedButton, FontWeight, IconThemeData, Image, RoundedRectangleBorder, Scaffold, SingleChildScrollView, SizedBox, StatelessWidget, Text, TextStyle, Widget;
import 'package:url_launcher/url_launcher.dart';

class NewsSeeMorePage extends StatelessWidget {
  final Map<String, dynamic> article;

  const NewsSeeMorePage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final title = article["title"] ?? "";
    final desc  = article["description"] ?? "";
    final content = article["content"] ?? "";
    final image  = article["image"];
    final date   = article["publishedAt"] ?? "";
    final url    = article["url"];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("뉴스 상세보기", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //뉴스 대표 이미지
            if (image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(image, height: 200, width: double.infinity, fit: BoxFit.cover),
              ),

            const SizedBox(height: 16),

            //제목
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            //날짜
            Text(
              date,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
            ),

            const SizedBox(height: 16),

            //설명
            Text(
              desc,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),

            const SizedBox(height: 16),

            Text(
              content,
              style: const TextStyle(fontSize: 15, height: 1.4),
            ),

            const SizedBox(height: 24),

            if (url != null)
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () async {
                    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text("원문 보기", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
