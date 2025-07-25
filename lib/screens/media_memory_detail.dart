import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/media_memory.model.dart';

class MediaMemoryDetailPage extends StatefulWidget {
  final String itemId;

  const MediaMemoryDetailPage({super.key, required this.itemId});

  @override
  State<MediaMemoryDetailPage> createState() => _MediaMemoryDetailPageState();
}

class _MediaMemoryDetailPageState extends State<MediaMemoryDetailPage> {
  late TextEditingController _locationController;
  late TextEditingController _memoController;
  bool _isEditingLocation = false;
  bool _isEditingMemo = false;
  DateTime _createdAt = DateTime.now();

  late String originalLocation;
  late String originalMemo;
  late DateTime originalCreatedAt;

  @override
  void initState() {
    super.initState();

    final memory = MediaMemory(
      url: 'https://example.com/photo.jpg',
      location: '서울숲 공원',
      memo: '햇살이 참 좋았던 날',
      createdAt: DateTime(2025, 7, 24),
    );

    _locationController = TextEditingController(text: memory.location);
    _memoController = TextEditingController(text: memory.memo);
    _createdAt = memory.createdAt;

    originalLocation = memory.location;
    originalMemo = memory.memo;
    originalCreatedAt = memory.createdAt;

    _locationController.addListener(_onFieldChanged);
    _memoController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() {
    setState(() {});
  }

  bool get _hasChanges =>
      _locationController.text != originalLocation ||
      _memoController.text != originalMemo ||
      !_isSameDate(_createdAt, originalCreatedAt);

  bool _isSameDate(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  void dispose() {
    _locationController.removeListener(_onFieldChanged);
    _memoController.removeListener(_onFieldChanged);
    _locationController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Media Memory')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
        child: ListView(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: colorScheme.outline,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(Icons.image, size: 48, color: colorScheme.tertiary),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _createdAt,
                  firstDate: DateTime(2000),
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
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                setState(() => _isEditingLocation = true);
              },
              child: _isEditingLocation
                  ? TextField(
                      controller: _locationController,
                      autofocus: true,
                      onSubmitted: (_) {
                        setState(() => _isEditingLocation = false);
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.location_on),
                        labelText: 'Location',
                      ),
                    )
                  : Row(
                      children: [
                        const Icon(Icons.location_on),
                        const SizedBox(width: 5),
                        Text(
                          _locationController.text,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
            ),
            const SizedBox(height: 20),
            Text(
              'Memo',
              style: TextStyle(fontSize: 14, color: colorScheme.tertiary),
            ),
            const SizedBox(height: 4),
            GestureDetector(
              onTap: () {
                setState(() => _isEditingMemo = true);
              },
              child: _isEditingMemo
                  ? TextField(
                      controller: _memoController,
                      autofocus: true,
                      maxLines: null,
                      onSubmitted: (_) {
                        setState(() => _isEditingMemo = false);
                      },
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
                    originalLocation = _locationController.text;
                    originalMemo = _memoController.text;
                    originalCreatedAt = _createdAt;
                    _isEditingLocation = false;
                    _isEditingMemo = false;
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
