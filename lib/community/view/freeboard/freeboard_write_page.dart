import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../view_model/freeboard/freeboard_view_model.dart';

//TODO - 글 작성 화면
class FreeBoardWritingPage extends StatefulWidget {
  const FreeBoardWritingPage({super.key});

  @override
  State<FreeBoardWritingPage> createState() => _FreeBoardWritingPageState();
}

class _FreeBoardWritingPageState extends State<FreeBoardWritingPage> {
  final _titleCtrl = TextEditingController();
  final _contentCtrl = TextEditingController();
  String _selectedIcon = "🏸";

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
        title: const Text("글 작성", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12, top: 8, bottom: 8),
            child: ElevatedButton(
              onPressed: () async {
                final title = _titleCtrl.text.trim();
                final content = _contentCtrl.text.trim();
                if (title.isEmpty || content.isEmpty) return;

                await vm.createPost(title, content, _selectedIcon);
                if (mounted) context.go('/community/freeboard');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              child: const Text("작성", style: TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 아이콘 선택 카드
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

            // 제목 입력 카드
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
                      hintText: "제목을 입력하세요",
                      counterText: "$titleLen/50",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // 내용 입력 카드
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
                      hintText: "내용을 입력하세요\n\n예시:\n- 배드민턴 동호회 모집합니다\n- 초보자도 환영합니다\n- 매주 토요일 오전 10시",
                      counterText: "$contentLen/500",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // 작성 팁 박스
            _CardBox(
              background: Colors.deepPurpleAccent.withOpacity(0.06),
              borderColor: Colors.deepPurpleAccent.withOpacity(0.35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    children: [
                      Icon(Icons.lightbulb_outline, color: Colors.deepPurpleAccent),
                      SizedBox(width: 6),
                      Text("작성 팁", style: TextStyle(fontWeight: FontWeight.w800)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text("• 구체적이고 명확한 제목을 작성해주세요"),
                  SizedBox(height: 4),
                  Text("• 욕설이나 비방은 삼가주세요"),
                  SizedBox(height: 4),
                  Text("• 연락처 등 개인정보는 공개하지 마세요"),
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
