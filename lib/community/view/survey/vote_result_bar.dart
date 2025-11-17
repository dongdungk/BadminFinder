import 'package:flutter/material.dart';

class VoteResultBar extends StatelessWidget {
  final String brand;
  final int percent;
  final int people;
  final Color color;

  const VoteResultBar({
    super.key,
    required this.brand,
    required this.percent,
    required this.people,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              brand,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Text(
              '$percent% ($people명)',
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),

        const SizedBox(height: 6),

        Container(
          height: 10,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(5),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: percent / 100,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
