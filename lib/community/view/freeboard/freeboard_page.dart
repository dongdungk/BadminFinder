import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_model/freeboard/freeboard_view_model.dart';
import 'freeboard_post_page.dart';
import 'freeboard_writing_page.dart';
import '../community_top_tabs.dart';

class FreeBoardPage extends StatelessWidget {
  const FreeBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FreeBoardViewModel>();

    viewModel.loadInitialData();

    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        children: [
          const SizedBox(height: 22),
          const CommunityTopTabs(),
          const SizedBox(height: 8),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: viewModel.posts.length,
              itemBuilder: (context, index) {
                final post = viewModel.posts[index];

                return GestureDetector(
                  onTap: () {
                    viewModel.selectPost(post);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const FreeBoardPostPage()),
                    );
                  },
                  child: _postItem(post),
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent.shade100,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FreeBoarCommentPage()),
          );
        },
        child: const Icon(Icons.edit, color: Colors.white),
      ),
    );
  }

  Widget _postItem(post) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.deepPurpleAccent.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(post.icon, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  post.title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          const SizedBox(height: 6),
          Text(post.content, maxLines: 2, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(post.time, style: const TextStyle(color: Colors.grey)),
              const SizedBox(width: 8),
              const Icon(Icons.remove_red_eye_outlined, size: 14),
              Text("${post.views}"),
              const SizedBox(width: 8),
              const Icon(Icons.thumb_up_alt_outlined, size: 14),
              Text("${post.likes}"),
            ],
          ),
        ],
      ),
    );
  }
}
