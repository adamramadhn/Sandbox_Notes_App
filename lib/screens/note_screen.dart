// lib/screens/notes_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandbox_notes_app/screens/note_detail_screen.dart';

import '../controllers/note_controller.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NoteController noteController = Get.put(NoteController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan Saya'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        if (noteController.notes.isEmpty) {
          return const Center(
            child: Text('Belum ada catatan. Tambahkan satu!'),
          );
        }
        return ListView.builder(
          itemCount: noteController.notes.length,
          itemBuilder: (context, index) {
            final note = noteController.notes[index];
            return ListTile(
              title: Text(note.title ?? ''),
              subtitle: Text(
                note.content ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                Get.to(() => NoteDetailScreen(note: note));
              },
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  noteController.deleteNote(note.id ?? '', context);
                },
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => NoteDetailScreen());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
