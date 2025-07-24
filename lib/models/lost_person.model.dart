import 'media_memory.model.dart';
import 'written_memory.model.dart';

class LostPerson {
  final DateTime dateOfDeath;
  final String memorialLocation;
  final List<MediaMemory> photos;
  final List<MediaMemory> videos;
  final List<WrittenMemory> notes;

  LostPerson({
    required this.dateOfDeath,
    required this.memorialLocation,
    List<MediaMemory>? photos,
    List<MediaMemory>? videos,
    List<WrittenMemory>? notes,
  }) : photos = photos ?? [],
       videos = videos ?? [],
       notes = notes ?? [];
}
