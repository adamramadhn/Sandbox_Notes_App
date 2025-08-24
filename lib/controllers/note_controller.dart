import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sandbox_notes_app/storage/note_item_model.dart';
import 'package:uuid/uuid.dart';

class NoteController extends GetxController {
  DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');
  final RxList<NoteItemModel> notes = <NoteItemModel>[].obs;

  // Deklarasikan Box untuk Hive
  late Box<NoteItemModel> _noteBox;

  // Gunakan onInit untuk memuat data saat controller pertama kali diinisialisasi
  @override
  void onInit() {
    super.onInit();
    _loadNotes();
  }

  // Fungsi untuk memuat data dari Hive
  void _loadNotes() async {
    // Buka box dengan nama 'notes'
    _noteBox = await Hive.openBox<NoteItemModel>('notes');
    // Muat semua catatan dari box
    notes.value = _noteBox.values.toList();
  }

  void addNote(String title, String content) async {
    final newNote = NoteItemModel(
      id: const Uuid().v4(),
      title: title,
      content: content,
      createdAt: dateFormat.format(DateTime.now()),
    );
    // Tambahkan catatan baru ke Hive
    await _noteBox.put(newNote.id, newNote);
    // Tambahkan catatan ke RxList
    notes.add(newNote);
  }

  void updateNote(String id, String newTitle, String newContent) async {
    final noteIndex = notes.indexWhere((note) => note.id == id);
    if (noteIndex != -1) {
      final noteToUpdate = notes[noteIndex];
      noteToUpdate.title = newTitle;
      noteToUpdate.content = newContent;
      noteToUpdate.lastEdited = dateFormat.format(DateTime.now());
      // Simpan perubahan ke Hive
      await noteToUpdate.save();
      notes.refresh();
    }
  }

  void deleteNote(String id, BuildContext context) {
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
                onPressed: () async {
                  // Hapus catatan dari Hive
                  await _noteBox.delete(id);
                  // Hapus catatan dari RxList
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

    if (lastEdited.year == now.year &&
        lastEdited.month == now.month &&
        lastEdited.day == now.day) {
      if (difference.inMinutes < 1) {
        return 'Baru saja';
      } else if (difference.inMinutes < 60) {
        return 'Hari ini ${difference.inMinutes} menit yang lalu';
      } else {
        return 'Hari ini ${difference.inHours} jam yang lalu';
      }
    }

    final yesterday = now.subtract(const Duration(days: 1));
    if (lastEdited.year == yesterday.year &&
        lastEdited.month == yesterday.month &&
        lastEdited.day == yesterday.day) {
      return 'Kemarin';
    }

    return DateFormat('dd/MM/yyyy').format(lastEdited);
  }
}
