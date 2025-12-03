import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../view_model/freeboard/freeboard_view_model.dart';
import '../../model/freeboard/post_model.dart';
import '../community_top_tabs.dart';

class FreeBoardPage extends StatelessWidget {
  const FreeBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<FreeBoardViewModel>();

    if (!vm.isLoading && vm.posts.isEmpty && vm.errorMessage == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<FreeBoardViewModel>().loadPosts();
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 22),
          const CommunityTopTabs(),
          const SizedBox(height: 8),
          Expanded(child: _buildBody(context, vm)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () => context.go('/community/freeboard/write'),
        child: const Icon(Icons.edit, color: Colors.white),
      ),
    );
  }

  Widget _buildBody(BuildContext context, FreeBoardViewModel vm) {
    if (vm.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (vm.errorMessage != null) {
      return Center(
        child: Text("에러: ${vm.errorMessage}",
            style: const TextStyle(color: Colors.red)),
      );
    }

    if (vm.posts.isEmpty) {
      return const Center(child: Text("게시글이 없습니다."));
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: vm.posts.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: const [
                Icon(Icons.chat_bubble_outline, color: Colors.deepPurpleAccent),
                SizedBox(width: 6),
                Text(
                  "자유게시판",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.deepPurpleAccent,
                  ),
                ),
              ],
            ),
          );
        }

        final post = vm.posts[index - 1];
        return _PostCard(post: post);
      },
    );
  }
}

class _PostCard extends StatelessWidget {
  final PostModel post;
  const _PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<FreeBoardViewModel>();

    return GestureDetector(
      onTap: () => context.go('/community/freeboard/post', extra: post),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(
              color: Colors.deepPurpleAccent.withOpacity(0.35), width: 1.4),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurpleAccent.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(post.icon, style: const TextStyle(fontSize: 18)),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.title,
                          style: const TextStyle(
                              fontSize: 15.5, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 6),
                      Text(
                        post.content,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style:
                        TextStyle(fontSize: 13, color: Colors.grey.shade700),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Divider(
                color: Colors.deepPurpleAccent.withOpacity(0.15), height: 1),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  _relativeTime(post.createdAt),
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                const SizedBox(width: 6),
                Text("익명",
                    style:
                    TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                const Spacer(),

                InkWell(
                  onTap: () => vm.toggleLike(post),
                  child: Row(
                    children: [
                      Icon(
                        vm.isLiked(post.id)
                            ? Icons.thumb_up
                            : Icons.thumb_up_outlined,
                        size: 16,
                        color: vm.isLiked(post.id)
                            ? Colors.deepPurpleAccent
                            : Colors.grey.shade700,
                      ),
                      const SizedBox(width: 4),
                      Text("${post.likes}",
                          style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                FutureBuilder<int>(
                  future: vm.getCommentCount(post.id),
                  builder: (context, snap) {
                    final count = snap.data ?? 0;
                    return Row(
                      children: [
                        Icon(Icons.chat_bubble_outline,
                            size: 16, color: Colors.grey.shade700),
                        const SizedBox(width: 4),
                        Text("$count",
                            style: const TextStyle(fontSize: 12)),
                      ],
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  static String _relativeTime(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return "방금 전";
    if (diff.inMinutes < 60) return "${diff.inMinutes}분 전";
    if (diff.inHours < 24) return "${diff.inHours}시간 전";
    return "${diff.inDays}일 전";
  }
}
