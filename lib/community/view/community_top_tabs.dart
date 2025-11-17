import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CommunityTopTabs extends StatelessWidget {
  const CommunityTopTabs({super.key}); // selected 제거

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    TextButton _tab(String label, String route) {
      final bool isSelected = location.contains(route);

      return TextButton(
        onPressed: () => context.go('/community/$route'),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _tab('자유게시판', 'freeboard'),
        _tab('대회', 'competition'),
        _tab('뉴스', 'news'),
        _tab('설문조사', 'survey'),
      ],
    );
  }
}
