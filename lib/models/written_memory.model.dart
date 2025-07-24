import 'memory.model.dart';

class WrittenMemory extends Memory {
  final String content;

  WrittenMemory({
    required this.content,
    required super.memo,
    required super.createdAt,
  });
}
