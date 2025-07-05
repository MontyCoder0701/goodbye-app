import 'media_item.model.dart';
import 'note.model.dart';

class LostPerson {
  final DateTime dateOfDeath;
  final String memorialLocation;
  final List<MediaItem> photos;
  final List<MediaItem> videos;
  final List<Note> notes;

  LostPerson({
    required this.dateOfDeath,
    required this.memorialLocation,
    List<MediaItem>? photos,
    List<MediaItem>? videos,
    List<Note>? notes,
  }) : photos = photos ?? [],
       videos = videos ?? [],
       notes = notes ?? [];
}
