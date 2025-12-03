import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../model/freeboard/post_model.dart';
import '../../view_model/freeboard/freeboard_view_model.dart';

//TODO - 게시글 수정
class FreeBoardEditPage extends StatefulWidget {
  final PostModel post;
  const FreeBoardEditPage({super.key, required this.post});

  @override
  State<FreeBoardEditPage> createState() => _FreeBoardEditPageState();
}

class _FreeBoardEditPageState extends State<FreeBoardEditPage> {
  late TextEditingController _titleCtrl;
  late TextEditingController _contentCtrl;
  late String _selectedIcon;

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController(text: widget.post.title);
    _contentCtrl = TextEditingController(text: widget.post.content);
    _selectedIcon = widget.post.icon;
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _contentCtrl.dispose();
    super.dispose();
  }

  void _openIconPicker() async {
    final icons = ["🏸", "🔥", "🎾", "💬", "📌", "🙋‍♂️", "✅", "⭐️"];
    final picked = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(18),
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: icons.map((ic) {
            return GestureDetector(
              onTap: () => Navigator.pop(context, ic),
              child: Container(
                width: 56,
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ic == _selectedIcon
                        ? Colors.deepPurpleAccent
                        : Colors.grey.shade300,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(ic, style: const TextStyle(fontSize: 24)),
              ),
            );
          }).toList(),
        ),
      ),
    );

    if (picked != null) {
      setState(() => _selectedIcon = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.read<FreeBoardViewModel>();
    final titleLen = _titleCtrl.text.length;
    final contentLen = _contentCtrl.text.length;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("게시글 수정", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12, top: 8, bottom: 8),
            child: ElevatedButton(
              onPressed: () async {
                await vm.updatePost(
                  widget.post.id,
                  _titleCtrl.text.trim(),
                  _contentCtrl.text.trim(),
                  _selectedIcon,
                );
                if (mounted) context.go("/community/freeboard");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              child: const Text("수정", style: TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _CardBox(
              child: Row(
                children: [
                  const Text("아이콘 (선택)", style: TextStyle(fontWeight: FontWeight.w700)),
                  const Spacer(),
                  OutlinedButton.icon(
                    onPressed: _openIconPicker,
                    icon: Text(_selectedIcon, style: const TextStyle(fontSize: 16)),
                    label: const Text("아이콘 선택"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black87,
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            _CardBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("제목 *", style: TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _titleCtrl,
                    maxLength: 50,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      counterText: "$titleLen/50",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            _CardBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("내용 *", style: TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _contentCtrl,
                    maxLength: 500,
                    onChanged: (_) => setState(() {}),
                    maxLines: 8,
                    decoration: InputDecoration(
                      counterText: "$contentLen/500",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardBox extends StatelessWidget {
  final Widget child;
  final Color background;
  final Color borderColor;

  const _CardBox({
    required this.child,
    this.background = Colors.white,
    this.borderColor = const Color(0xFFEDE8FF),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: child,
    );
  }
}
