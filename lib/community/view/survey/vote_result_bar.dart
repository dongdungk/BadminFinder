import 'package:flutter/material.dart';

class VoteResultBar extends StatelessWidget {
  final String title;
  final int percent;
  final int votes;
  final Color color;

  const VoteResultBar({
    super.key,
    required this.title,
    required this.percent,
    required this.votes,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        //브랜드 이름 + 퍼센트
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w600)),
            Text("$percent%",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                )),
          ],
        ),

        const SizedBox(height: 6),

        //막대 바
        Stack(
          children: [
            Container(
              height: 10,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            Container(
              height: 10,
              width: MediaQuery.of(context).size.width * (percent / 100),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ],
        ),

        const SizedBox(height: 6),

        //득표수
        Text(
          "$votes표",
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
