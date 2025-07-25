import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/media_memory.model.dart';

class MediaMemoryDetailPage extends StatelessWidget {
  final String itemId;

  const MediaMemoryDetailPage({super.key, required this.itemId});

  @override
  Widget build(BuildContext context) {
    final memory = MediaMemory(
      url: 'https://example.com/photo.jpg',
      location: '서울숲 공원',
      memo: '햇살이 참 좋았던 날',
      createdAt: DateTime(2025, 7, 24),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Media Memory')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Icon(Icons.image, size: 48, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              DateFormat.yMMMMd().format(memory.createdAt),
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            const Text(
              '메모',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(memory.memo, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 12),
            const Text(
              '위치',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(memory.location, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
