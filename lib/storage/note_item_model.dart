import 'package:hive/hive.dart';

part 'note_item_model.g.dart';

@HiveType(typeId: 1)
class NoteItemModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String content;

  @HiveField(3)
  String createdAt;

  @HiveField(4)
  String? lastEdited;

  NoteItemModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    this.lastEdited,
  });
}
