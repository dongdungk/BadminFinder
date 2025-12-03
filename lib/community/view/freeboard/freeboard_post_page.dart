import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../model/freeboard/post_model.dart';
import '../../view_model/freeboard/freeboard_view_model.dart';

class FreeBoardPostPage extends StatefulWidget {
  final PostModel post;
  const FreeBoardPostPage({super.key, required this.post});

  @override
  State<FreeBoardPostPage> createState() => _FreeBoardPostPageState();
}

class _FreeBoardPostPageState extends State<FreeBoardPostPage> {
  final _commentCtrl = TextEditingController();

  @override
  void dispose() {
    _commentCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<FreeBoardViewModel>();
    final post = vm.posts.firstWhere(
          (p) => p.id == widget.post.id,
      orElse: () => widget.post,
    );

    final isPostOwner = post.userId == vm.currentUid;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("자유게시판", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          if (isPostOwner)
            IconButton(
              onPressed: () =>
                  context.go('/community/freeboard/edit', extra: post),
              icon: const Icon(Icons.edit, color: Colors.black),
            ),
          if (isPostOwner)
            IconButton(
              onPressed: () async {
                try {
                  await vm.deletePost(post.id);
                  if (mounted) context.pop();
                } catch (e) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString())),
                  );
                }
              },
              icon: const Icon(Icons.delete_outline, color: Colors.black),
            ),
          IconButton(
            onPressed: () => _openPostMoreSheet(vm, post),
            icon: const Icon(Icons.more_vert, color: Colors.black),
          ),
        ],
      ),
      body: Column(
        children: [
          _postCard(vm, post),
          const SizedBox(height: 6),
          Expanded(child: _commentSection(vm, post)),
          _commentInput(vm, post.id),
        ],
      ),
    );
  }

  // ---------------- 게시글 더보기 ----------------
  void _openPostMoreSheet(FreeBoardViewModel vm, PostModel post) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 6),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              const SizedBox(height: 10),

              ListTile(
                leading: const Icon(Icons.report_outlined),
                title: const Text("게시글 신고"),
                onTap: () {
                  Navigator.pop(context);
                  _openPostReportDialog(vm, post.id);
                },
              ),

              ListTile(
                leading: const Icon(Icons.hide_source_outlined),
                title: const Text("이 게시글 숨기기"),
                onTap: () {
                  vm.hidePost(post.id);
                  Navigator.pop(context);
                  context.pop();
                },
              ),

              ListTile(
                leading: const Icon(Icons.block_outlined),
                title: const Text("작성자 차단"),
                onTap: () {
                  vm.blockPostAuthor(post.userId); // ✅ uid 기반
                  Navigator.pop(context);
                  context.pop();
                },
              ),

              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  void _openPostReportDialog(FreeBoardViewModel vm, String postId) {
    final ctrl = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("게시글 신고"),
        content: TextField(
          controller: ctrl,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: "신고 사유를 입력해주세요",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("취소"),
          ),
          TextButton(
            onPressed: () async {
              final reason = ctrl.text.trim();
              if (reason.isNotEmpty) {
                await vm.reportPost(postId: postId, reason: reason);
              }
              if (mounted) Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("신고가 접수되었습니다.")),
              );
            },
            child: const Text("신고"),
          ),
        ],
      ),
    );
  }

  // ---------------- 게시글 카드 ----------------
  Widget _postCard(FreeBoardViewModel vm, PostModel post) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.deepPurpleAccent.withOpacity(0.35),
          width: 1.4,
        ),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(post.icon, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  post.title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(post.content,
              style: const TextStyle(fontSize: 15, height: 1.5)),
          const SizedBox(height: 12),
          Text("${_relativeTime(post.createdAt)} · 익명",
              style:
              TextStyle(fontSize: 12, color: Colors.grey.shade600)),
          const SizedBox(height: 10),
          Divider(
              color: Colors.deepPurpleAccent.withOpacity(0.15), height: 1),
          const SizedBox(height: 8),
          Row(
            children: [
              InkWell(
                onTap: () => vm.toggleLike(post),
                child: Row(
                  children: [
                    Icon(
                      vm.isLiked(post.id)
                          ? Icons.thumb_up
                          : Icons.thumb_up_outlined,
                      size: 18,
                      color: vm.isLiked(post.id)
                          ? Colors.deepPurpleAccent
                          : Colors.grey.shade700,
                    ),
                    const SizedBox(width: 4),
                    Text("${post.likes}",
                        style: const TextStyle(fontSize: 13)),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // ---------------- 댓글 영역 ----------------
  Widget _commentSection(FreeBoardViewModel vm, PostModel post) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.deepPurpleAccent.withOpacity(0.25),
        ),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: StreamBuilder<QuerySnapshot>(
        stream: vm.streamComments(post.id),
        builder: (context, snap) {
          if (snap.hasError) {
            return Center(
              child: Text(
                "댓글 로딩 오류\n${snap.error}",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            );
          }

          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          // ✅ 숨김/차단 필터 (authorUid 기반)
          final docs = snap.data!.docs.where((d) {
            final data = d.data() as Map<String, dynamic>? ?? {};
            final authorUid = (data["userId"] ?? "").toString();
            if (vm.isHiddenComment(d.id)) return false;
            if (vm.isBlockedCommentAuthor(authorUid)) return false;
            return true;
          }).toList();

          return ListView(
            children: [
              Text("댓글 ${docs.length}개",
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 15)),
              const SizedBox(height: 8),

              if (docs.isEmpty)
                const Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Center(child: Text("댓글이 없습니다.")),
                ),

              ...docs.map((d) {
                final data = d.data() as Map<String, dynamic>? ?? {};
                final commentId = d.id;

                final nick = (data["nickname"] ?? "익명").toString();
                final content = (data["content"] ?? "").toString();
                final authorUid = (data["userId"] ?? "").toString();
                final ts = data["createdAt"];
                final dt = ts is Timestamp ? ts.toDate() : DateTime.now();

                final isCommentOwner = authorUid == vm.currentUid;
                final isPostOwner = post.userId == vm.currentUid;

                return _commentItem(
                  vm: vm,
                  commentId: commentId,
                  nick: nick,
                  content: content,
                  dt: dt,
                  authorUid: authorUid,
                  postOwnerUid: post.userId,
                  isCommentOwner: isCommentOwner,
                  isPostOwner: isPostOwner,
                );
              }),
            ],
          );
        },
      ),
    );
  }

  // ---------------- 댓글 1개 ----------------
  Widget _commentItem({
    required FreeBoardViewModel vm,
    required String commentId,
    required String nick,
    required String content,
    required DateTime dt,
    required String authorUid,
    required String postOwnerUid,
    required bool isCommentOwner,
    required bool isPostOwner,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(nick,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 14)),
              const SizedBox(width: 6),
              Text(_relativeTime(dt),
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
              const Spacer(),

              // ✅ 댓글 수정 = 본인 댓글일 때만
              if (isCommentOwner)
                InkWell(
                  onTap: () => _editCommentDialog(vm, commentId, content),
                  child:
                  Icon(Icons.edit, size: 16, color: Colors.grey.shade700),
                ),

              if (isCommentOwner) const SizedBox(width: 12),

              // ✅ 댓글 삭제 = 본인 댓글 OR 내 게시글의 댓글
              if (isCommentOwner || isPostOwner)
                InkWell(
                  onTap: () async {
                    try {
                      await vm.deleteComment(
                        commentId: commentId,
                        postOwnerUid: postOwnerUid,
                      );
                    } catch (e) {
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString())),
                      );
                    }
                  },
                  child: Icon(Icons.delete_outline,
                      size: 16, color: Colors.grey.shade700),
                ),

              if (isCommentOwner || isPostOwner) const SizedBox(width: 12),

              InkWell(
                onTap: () => _openCommentMoreSheet(vm, commentId, authorUid),
                child: Icon(Icons.more_vert,
                    size: 16, color: Colors.grey.shade700),
              ),
            ],
          ),

          const SizedBox(height: 6),
          Text(content, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 8),
          Divider(color: Colors.grey.shade200),
        ],
      ),
    );
  }

  // ---------------- 댓글 더보기 ----------------
  void _openCommentMoreSheet(
      FreeBoardViewModel vm, String commentId, String authorUid) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 6),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              const SizedBox(height: 10),

              ListTile(
                leading: const Icon(Icons.report_outlined),
                title: const Text("댓글 신고"),
                onTap: () {
                  Navigator.pop(context);
                  _openCommentReportDialog(vm, commentId);
                },
              ),

              ListTile(
                leading: const Icon(Icons.hide_source_outlined),
                title: const Text("이 댓글 숨기기"),
                onTap: () {
                  vm.hideComment(commentId);
                  Navigator.pop(context);
                },
              ),

              ListTile(
                leading: const Icon(Icons.block_outlined),
                title: const Text("작성자 차단"),
                onTap: () {
                  vm.blockCommentAuthor(authorUid); // ✅ uid 기반
                  Navigator.pop(context);
                },
              ),

              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  void _openCommentReportDialog(FreeBoardViewModel vm, String commentId) {
    final ctrl = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("댓글 신고"),
        content: TextField(
          controller: ctrl,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: "신고 사유를 입력해주세요",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("취소"),
          ),
          TextButton(
            onPressed: () async {
              final reason = ctrl.text.trim();
              if (reason.isNotEmpty) {
                await vm.reportComment(commentId: commentId, reason: reason);
              }
              if (mounted) Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("신고가 접수되었습니다.")),
              );
            },
            child: const Text("신고"),
          ),
        ],
      ),
    );
  }

  // ---------------- 댓글 입력 ----------------
  Widget _commentInput(FreeBoardViewModel vm, String postId) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _commentCtrl,
              decoration: InputDecoration(
                hintText: "댓글을 입력하세요...",
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: () async {
              final text = _commentCtrl.text.trim();
              if (text.isEmpty) return;
              await vm.addComment(postId, text);
              _commentCtrl.clear();
            },
            child: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.deepPurpleAccent,
              ),
              child: const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _editCommentDialog(
      FreeBoardViewModel vm, String commentId, String oldContent) {
    final ctrl = TextEditingController(text: oldContent);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("댓글 수정"),
        content: TextField(
          controller: ctrl,
          maxLines: null,
          decoration: const InputDecoration(hintText: "수정할 내용을 입력하세요"),
        ),
        actions: [
          TextButton(
            child: const Text("취소"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text("저장"),
            onPressed: () async {
              try {
                await vm.editComment(commentId, ctrl.text.trim());
                if (mounted) Navigator.pop(context);
              } catch (e) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(e.toString())),
                );
              }
            },
          ),
        ],
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
