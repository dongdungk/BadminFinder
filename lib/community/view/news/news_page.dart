import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../view_model/news/news_view_model.dart';
import '../../model/news/news_model.dart';
import '../community_top_tabs.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<NewsViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 22),
          const CommunityTopTabs(),
          const SizedBox(height: 8),

          Expanded(
            child: _buildBody(vm, context),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(NewsViewModel vm, BuildContext context) {
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

    if (vm.news.isEmpty) {
      return const Center(
        child: Text("표시할 뉴스가 없습니다."),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: vm.news.length,
      itemBuilder: (context, index) {
        final item = vm.news[index];

        return GestureDetector(
          onTap: () {
            context.push(
              "/community/news/seemore",
              extra: {
                "title": item.title,
                "description": item.description,
                "content": item.description, // GNews는 content가 description과 동일한 경우 많음
                "image": item.imageUrl,
                "publishedAt": item.publishedAt,
                "url": item.url,
                "source": item.source,
              },
            );
          },
          child: _NewsCard(item),
        );
      },
    );
  }
}

class _NewsCard extends StatelessWidget {
  final NewsModel news;

  const _NewsCard(this.news);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(),
          const SizedBox(width: 12),
          _buildText(),
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (news.imageUrl.isNotEmpty && news.imageUrl.startsWith("http")) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          news.imageUrl,
          width: 110,
          height: 80,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _fallbackImage(),
        ),
      );
    }
    return _fallbackImage();
  }

  Widget _fallbackImage() {
    return Container(
      width: 110,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.image_not_supported),
    );
  }

  Widget _buildText() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            news.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          Text(
            news.source,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
          const SizedBox(height: 4),
          Text(
            news.publishedAt.isNotEmpty
                ? news.publishedAt.substring(0, 10)
                : "",
            style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}
