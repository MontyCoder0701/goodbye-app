import 'memory.model.dart';

class MediaMemory extends Memory {
  final String url;
  final String location;

  MediaMemory({
    required this.url,
    required this.location,
    required super.memo,
    required super.createdAt,
  });
}
