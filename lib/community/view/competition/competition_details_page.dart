import 'package:flutter/material.dart';
import '../../model/competition/competition_model.dart';

class CompetitionDetailPage extends StatelessWidget {
  final CompetitionModel comp;

  const CompetitionDetailPage({super.key, required this.comp});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          comp.name,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //대표 사진
            if (comp.thumb != null && comp.thumb!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  comp.thumb!,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

            const SizedBox(height: 20),

            //대회 이름
            Text(
              comp.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            // 날짜
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  comp.date,
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                const Icon(Icons.flag, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  comp.country,
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Divider(thickness: 1),

            const SizedBox(height: 20),

            if (comp.description != null && comp.description!.isNotEmpty)
              Text(
                comp.description!,
                style: const TextStyle(fontSize: 15, height: 1.6),
              )
            else
              const Text(
                "상세 설명이 제공되지 않습니다.",
                style: TextStyle(color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }
}
