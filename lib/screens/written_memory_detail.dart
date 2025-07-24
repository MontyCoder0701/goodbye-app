import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/written_memory.model.dart';

class WrittenMemoryDetailPage extends StatelessWidget {
  final String itemId;

  const WrittenMemoryDetailPage({super.key, required this.itemId});

  @override
  Widget build(BuildContext context) {
    final memory = WrittenMemory(
      memo: '산책하면서 느꼈던 따뜻한 기분을 기록함',
      content:
          '오늘은 오랜만에 따뜻한 햇살이 비췄고, 나는 공원에서 산책을 하며 마음을 정리했다. 따뜻한 바람과 웃는 사람들, 벤치에 앉아있던 고양이까지 모든 것이 평화로웠다.',
      createdAt: DateTime(2025, 7, 24),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Written Memory')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat.yMMMMd().format(memory.createdAt),
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            const Text(
              '본문',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(memory.content, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 12),
            const Text(
              '메모',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(memory.memo, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
