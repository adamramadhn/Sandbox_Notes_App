import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sandbox_notes_app/models/note_item_model.dart';
import 'package:uuid/uuid.dart';

class NoteController extends GetxController {
  DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');
  final RxList<NoteItemModel> notes =
      <NoteItemModel>[
        // Contoh data awal
        // NoteItemModel(
        //   id: const Uuid().v4(),
        //   title: 'Catatan Pertama',
        //   content: 'Ini adalah isi dari catatan pertama.',
        //   createdAt: DateTime.now(),
        // ),
      ].obs;

  void addNote(String title, String content) {
    final newNote = NoteItemModel(
      id: const Uuid().v4(),
      title: title,
      content: content,
      createdAt: dateFormat.format(DateTime.now()),
    );
    notes.add(newNote);
  }

  void updateNote(String id, String newTitle, String newContent) {
    final noteIndex = notes.indexWhere((note) => note.id == id);
    if (noteIndex != -1) {
      notes[noteIndex].title = newTitle;
      notes[noteIndex].content = newContent;
      notes[noteIndex].lastEdited = dateFormat.format(DateTime.now());
      notes.refresh(); // Memperbarui tampilan secara manual
    }
  }

  void deleteNote(String id, BuildContext context) {
    // pop up apakah anda yakin ingin menghapus catatan ini?
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog.adaptive(
            backgroundColor: Colors.white,
            title: Text(
              'Hapus Catatan',
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(color: Color(0xff394675)),
            ),
            content: Text(
              'Apakah anda yakin ingin menghapus catatan ini?',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Color(0xff394675)),
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  'Batal',
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium?.copyWith(color: Color(0xff394675)),
                ),
              ),
              TextButton(
                onPressed: () {
                  notes.removeWhere((note) => note.id == id);
                  Get.back();
                  Get.back();
                },
                child: Text(
                  'Hapus',
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium?.copyWith(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }

  String formatLastEdited(DateTime? lastEdited) {
    if (lastEdited == null) return '';
    final now = DateTime.now();
    final difference = now.difference(lastEdited);

    // Jika hari sama persis (tanpa memperhatikan jam)
    if (lastEdited.year == now.year &&
        lastEdited.month == now.month &&
        lastEdited.day == now.day) {
      if (difference.inMinutes < 1) {
        return 'Baru saja';
      } else if (difference.inMinutes < 60) {
        return 'Hari ini ${difference.inMinutes} menit yang lalu';
      } else if (difference.inHours < 24) {
        return 'Hari ini ${difference.inHours} jam yang lalu';
      }
    }

    // Jika tanggal kemarin
    final yesterday = now.subtract(const Duration(days: 1));
    if (lastEdited.year == yesterday.year &&
        lastEdited.month == yesterday.month &&
        lastEdited.day == yesterday.day) {
      return 'Kemarin';
    }

    // Format standar untuk tanggal lainnya
    return '${lastEdited.day}/${lastEdited.month}/${lastEdited.year}';
  }
}
