import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/written_memory.model.dart';

class WrittenMemoryDetailPage extends StatefulWidget {
  final String itemId;

  const WrittenMemoryDetailPage({super.key, required this.itemId});

  @override
  State<WrittenMemoryDetailPage> createState() =>
      _WrittenMemoryDetailPageState();
}

class _WrittenMemoryDetailPageState extends State<WrittenMemoryDetailPage> {
  late TextEditingController _memoController;
  late TextEditingController _contentController;

  bool _isEditingMemo = false;
  bool _isEditingContent = false;

  late String _originalMemo;
  late String _originalContent;
  late DateTime _createdAt;
  late DateTime _originalCreatedAt;

  @override
  void initState() {
    super.initState();

    final memory = WrittenMemory(
      memo: '산책하면서 느꼈던 따뜻한 기분을 기록함',
      content:
          '오늘은 오랜만에 따뜻한 햇살이 비췄고, 나는 공원에서 산책을 하며 마음을 정리했다. 따뜻한 바람과 웃는 사람들, 벤치에 앉아있던 고양이까지 모든 것이 평화로웠다.',
      createdAt: DateTime(2025, 7, 24),
    );

    _memoController = TextEditingController(text: memory.memo);
    _contentController = TextEditingController(text: memory.content);

    _originalMemo = memory.memo;
    _originalContent = memory.content;
    _createdAt = memory.createdAt;
    _originalCreatedAt = memory.createdAt;

    _memoController.addListener(() => setState(() {}));
    _contentController.addListener(() => setState(() {}));
  }

  bool get _hasChanges =>
      _memoController.text != _originalMemo ||
      _contentController.text != _originalContent ||
      !_isSameDate(_createdAt, _originalCreatedAt);

  bool _isSameDate(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  void dispose() {
    _memoController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Written Memory')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
        child: ListView(
          children: [
            InkWell(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _createdAt,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (picked != null && !_isSameDate(picked, _createdAt)) {
                  setState(() => _createdAt = picked);
                }
              },
              borderRadius: BorderRadius.circular(8),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today_rounded),
                  const SizedBox(width: 8),
                  Text(
                    DateFormat.yMMMMd().format(_createdAt),
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () => setState(() => _isEditingContent = true),
              child: _isEditingContent
                  ? TextField(
                      controller: _contentController,
                      autofocus: true,
                      maxLines: null,
                      onSubmitted: (_) =>
                          setState(() => _isEditingContent = false),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: colorScheme.outline),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _contentController.text,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
            ),
            const SizedBox(height: 20),
            Text(
              'Memo',
              style: TextStyle(fontSize: 14, color: colorScheme.tertiary),
            ),
            const SizedBox(height: 4),
            GestureDetector(
              onTap: () => setState(() => _isEditingMemo = true),
              child: _isEditingMemo
                  ? TextField(
                      controller: _memoController,
                      autofocus: true,
                      maxLines: null,
                      onSubmitted: (_) =>
                          setState(() => _isEditingMemo = false),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    )
                  : Text(
                      _memoController.text,
                      style: const TextStyle(fontSize: 16),
                    ),
            ),
            if (_hasChanges) ...{
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: Icon(Icons.check),
                label: Text('Save Changes'),
                onPressed: () {
                  setState(() {
                    _originalMemo = _memoController.text;
                    _originalContent = _contentController.text;
                    _originalCreatedAt = _createdAt;
                    _isEditingMemo = false;
                    _isEditingContent = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Changes saved')),
                  );
                },
              ),
            },
          ],
        ),
      ),
    );
  }
}
