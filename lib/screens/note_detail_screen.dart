import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandbox_notes_app/models/note_item_model.dart';

import '../controllers/note_controller.dart';

class NoteDetailScreen extends StatefulWidget {
  final NoteItemModel? note;

  const NoteDetailScreen({super.key, this.note});

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _noteController;
  final NoteController noteController = Get.find();
  final FocusNode _focusNode = FocusNode();
  late String _initialNoteContent;

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
    final initialContent =
        (widget.note?.title != null && widget.note?.title?.isNotEmpty == true)
            ? '${widget.note!.title}\n${widget.note!.content}'
            : widget.note?.content ?? '';
    _noteController = TextEditingController(text: initialContent);
    _initialNoteContent = initialContent;
  }

  @override
  void dispose() {
    _noteController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _saveNote({bool isAutoSave = false}) {
    final fullText = _noteController.text;
    if (isAutoSave && fullText == _initialNoteContent) {
      return;
    }
    if (fullText.isEmpty) {
      Get.back();
      Get.back();
      return;
    }

    final lines = fullText.split('\n');
    final title = lines.isNotEmpty ? lines.first : '';
    final content = lines.length > 1 ? lines.sublist(1).join('\n') : '';

    if (widget.note == null) {
      noteController.addNote(title, content);
    } else {
      noteController.updateNote(widget.note!.id!, title, content);
    }
    _initialNoteContent = _noteController.text;
    if (!isAutoSave) {
      Get.back();
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          _saveNote(isAutoSave: true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.note == null ? 'Catatan Baru' : 'Edit Catatan'),
          backgroundColor: Color(0xff394675),
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              color: Colors.white,
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.white,
                  context: context,
                  isScrollControlled: true,
                  builder:
                      (context) => Container(
                        padding: EdgeInsets.only(
                          left: 24,
                          right: 24,
                          top: 16,
                          bottom: MediaQuery.viewPaddingOf(context).bottom,
                        ),
                        width: MediaQuery.sizeOf(context).width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            manageNote(
                              onTap: _saveNote,
                              context: context,
                              icon: Icons.save,
                              label: "Simpan Catatan",
                            ),
                            if (widget.note != null) ...[
                              Divider(color: Color(0xff394675)),
                              manageNote(
                                onTap:
                                    () => noteController.deleteNote(
                                      widget.note!.id!,
                                      context,
                                    ),
                                context: context,
                                icon: Icons.delete,
                                label: "Hapus Catatan",
                              ),
                            ],
                          ],
                        ),
                      ),
                );
              },
              icon: const Icon(Icons.more_horiz),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.viewPaddingOf(context).bottom,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: TextFormField(
                    focusNode: _focusNode,
                    controller: _noteController,
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(0),
                    ),
                  ),
                ),
                if (widget.note?.createdAt != null)
                  Column(
                    children: [
                      if (widget.note?.lastEdited != null)
                        Text(
                          "Diubah Pada: ${noteController.formatLastEdited(DateTime.tryParse(widget.note?.lastEdited ?? ''))}",
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                        ),

                      SizedBox(height: 2),
                      Text(
                        "Dibuat Pada: ${noteController.formatLastEdited(DateTime.tryParse(widget.note?.createdAt ?? ''))}",
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget manageNote({
  required VoidCallback onTap,
  required BuildContext context,
  required IconData icon,
  required String label,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        spacing: 8,
        children: [
          // Icon(icon, color: color),
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(color: Color(0xff394675)),
          ),
        ],
      ),
    ),
  );
}
