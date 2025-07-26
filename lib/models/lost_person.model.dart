import 'package:intl/intl.dart';

import 'base.model.dart';
import 'media_memory.model.dart';
import 'written_memory.model.dart';

class LostPerson extends BaseModel {
  final String name;
  final String? nickname;
  final DateTime? dateOfDeath;
  final String? memorialLocation;
  final String? profileImageUrl;
  final List<MediaMemory> photos;
  final List<MediaMemory> videos;
  final List<WrittenMemory> notes;

  LostPerson({
    required this.name,
    this.nickname,
    this.dateOfDeath,
    this.memorialLocation,
    this.profileImageUrl,
    List<MediaMemory>? photos,
    List<MediaMemory>? videos,
    List<WrittenMemory>? notes,
  }) : photos = photos ?? [],
       videos = videos ?? [],
       notes = notes ?? [];

  String get displayName => nickname ?? name;

  String? get displayDateOfDeath =>
      dateOfDeath != null ? DateFormat.yMMMMd().format(dateOfDeath!) : null;

  bool get hasMemories =>
      photos.isNotEmpty || videos.isNotEmpty || notes.isNotEmpty;
}
