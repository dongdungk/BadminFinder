import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../model/competition/competition_model.dart';
import '../../view_model/competition/competition_view_model.dart';
import '../community_top_tabs.dart';
import 'competition_details_page.dart';

class CompetitionPage extends StatelessWidget {
  const CompetitionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CompetitionViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 22),

          const CommunityTopTabs(),

          const SizedBox(height: 8),

          Expanded(
            child: _buildBody(vm),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(CompetitionViewModel vm) {
    if (vm.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (vm.errorMessage != null) {
      return Center(
        child: Text(
          "에러: ${vm.errorMessage}",
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    if (vm.competitions.isEmpty) {
      return const Center(
        child: Text("표시할 대회 정보가 없습니다."),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: vm.competitions.length,
      itemBuilder: (context, index) {
        final item = vm.competitions[index];
        return _CompetitionCard(c: item);
      },
    );
  }
}

class _CompetitionCard extends StatelessWidget {
  final CompetitionModel c;

  const _CompetitionCard({required this.c});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          "/community/competition/details",
          extra: c,
        );
      },

      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.12),
              blurRadius: 6,
              offset: const Offset(0, 3),
            )
          ],
        ),

        child: Row(
          children: [
            // 썸네일 표시
            if (c.thumb != null && c.thumb!.isNotEmpty)
              Container(
                width: 70,
                height: 70,
                margin: const EdgeInsets.only(right: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(c.thumb!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(c.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  Text(c.date,
                      style:
                      TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                  const SizedBox(height: 4),
                  Text(c.country,
                      style:
                      TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}