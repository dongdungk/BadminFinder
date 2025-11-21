// 커뮤니티 - 자유게시판 - 게시글작성 view ui
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_model/freeboard/freeboard_view_model.dart';

class FreeBoarCommentPage extends StatefulWidget {
  const FreeBoarCommentPage({super.key});

  @override
  State<FreeBoarCommentPage> createState() => _FreeBoarCommentPageState();
}

class _FreeBoarCommentPageState extends State<FreeBoarCommentPage> {
  String selectedIcon = "🏸";
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  final List<String> iconList = ["🏸", "💬", "🔍", "💪", "⭐", "🎥", "😆", "😢"];

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<FreeBoardViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        title: const Text("글 작성", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,

        actions: [
          GestureDetector(
            onTap: () {
              if (titleController.text.trim().isEmpty ||
                  contentController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("제목과 내용을 입력해주세요.")),
                );
                return;
              }

              viewModel.addPost(
                selectedIcon,
                titleController.text.trim(),
                contentController.text.trim(),
              );

              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '작성',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //아이콘 선택
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border:
                Border.all(color: Colors.deepPurpleAccent.shade100),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('아이콘 (선택)',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),

                  Wrap(
                    spacing: 10,
                    children: iconList.map((icon) {
                      bool isSelected = (selectedIcon == icon);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIcon = icon;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: isSelected
                                    ? Colors.deepPurpleAccent
                                    : Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(icon, style: const TextStyle(fontSize: 25)),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border:
                Border.all(color: Colors.deepPurpleAccent.shade100),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('제목 *',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: titleController,
                    maxLength: 50,
                    decoration: InputDecoration(
                      hintText: '제목을 입력하세요',
                      counterText: '',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(color: Colors.black45, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.deepPurpleAccent, width: 1.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            //내용 입력
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border:
                Border.all(color: Colors.deepPurpleAccent.shade100),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('내용 *',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: contentController,
                    maxLines: 8,
                    maxLength: 500,
                    decoration: InputDecoration(
                      hintText: '내용을 입력하세요',
                      counterText: '',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(color: Colors.black45, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.deepPurpleAccent, width: 1.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            //작성 팁
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border:
                Border.all(color: Colors.deepPurpleAccent.shade100),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lightbulb_outline,
                          color: Colors.amber, size: 20),
                      SizedBox(width: 4),
                      Text('작성 팁',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    '- 구체적이고 명확한 제목을 작성해주세요\n'
                        '- 욕설이나 비방은 삼가주세요\n'
                        '- 개인정보는 절대 적지 마세요',
                    style: TextStyle(color: Colors.deepPurpleAccent),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
