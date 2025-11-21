// 커뮤니티 - 자유게시판 - 게시글 상세 + 댓글 UI
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/freeboard/writing_model.dart';
import '../../view_model/freeboard/freeboard_view_model.dart';
import '../../view_model/freeboard/writing_view_model.dart';

class FreeBoardPostPage extends StatelessWidget {
  const FreeBoardPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final postViewModel = Provider.of<FreeBoardViewModel>(context);
    final commentViewModel = Provider.of<CommentViewModel>(context);

    final post = postViewModel.selectedPost;

    if (post == null) {
      return const Scaffold(
        body: Center(
          child: Text("게시글을 찾을 수 없습니다."),
        ),
      );
    }

    postViewModel.increaseViews(post.id);

    final comments = commentViewModel.getCommentsByPost(post.id);

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        title: const Text("자유게시판", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //게시글 본문
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.deepPurpleAccent.shade100),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(post.icon, style: const TextStyle(fontSize: 22)),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          post.title,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Text(
                    post.content,
                    style: const TextStyle(fontSize: 15, height: 1.5),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Text(post.time,
                          style:
                          const TextStyle(fontSize: 12, color: Colors.grey)),
                      const Spacer(),

                      GestureDetector(
                        onTap: () {
                          postViewModel.likePost(post.id);
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.thumb_up_alt_outlined,
                                color: Colors.deepPurple, size: 18),
                            const SizedBox(width: 4),
                            Text(
                              "${post.likes}",
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            //댓글 수
            Text(
              "댓글 ${comments.length}개",
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            //댓글 목록
            ...comments.map(
                  (c) => _buildCommentItem(context, c, commentViewModel),
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),

      //댓글 입력창
      bottomNavigationBar:
      _buildCommentInput(context, commentViewModel, post.id),
    );
  }

  //시간
  String _formatTime(DateTime time) {
    Duration diff = DateTime.now().difference(time);

    if (diff.inMinutes < 1) return "방금 전";
    if (diff.inMinutes < 60) return "${diff.inMinutes}분 전";
    if (diff.inHours < 24) return "${diff.inHours}시간 전";
    return "${diff.inDays}일 전";
  }

  //댓글 한 개
  Widget _buildCommentItem(
      BuildContext context,
      CommentModel comment,
      CommentViewModel viewModel,
      ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //닉네임 + 시간
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(comment.writer,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
              Text(
                _formatTime(comment.createdAt),
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),

          const SizedBox(height: 6),

          //내용
          Text(comment.content,
              style: const TextStyle(fontSize: 14, color: Colors.black87)),

          const SizedBox(height: 6),

          //공감 버튼
          GestureDetector(
            onTap: () => viewModel.likeComment(comment.id),
            child: Row(
              children: [
                const Icon(Icons.thumb_up_alt_outlined,
                    size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text("공감 ${comment.likes}",
                    style: const TextStyle(fontSize: 13, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //댓글 입력창
  Widget _buildCommentInput(
      BuildContext context,
      CommentViewModel viewModel,
      String postId,
      ) {
    final controller = TextEditingController();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
        color: Colors.white,
      ),
      child: Row(
        children: [
          // 입력창
          Expanded(
            child: Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: "댓글을 입력하세요...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          const SizedBox(width: 8),

          //전송 버튼
          GestureDetector(
            onTap: () {
              if (controller.text.isEmpty) return;

              viewModel.addComment(
                postId: postId,
                writer: "익명",
                content: controller.text.trim(),
              );

              controller.clear();
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent.shade100,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send, size: 20, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
