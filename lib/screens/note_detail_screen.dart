import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandbox_notes_app/storage/note_item_model.dart';

import '../controllers/note_controller.dart';

class NoteDetailScreen extends StatefulWidget {
  final NoteItemModel? note;

  const NoteDetailScreen({super.key, this.note});

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  final NoteController noteController = Get.find();
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _contentController;
  late TextEditingController _titleController;
  final FocusNode _focusNodeTitle = FocusNode();
  final FocusNode _focusNodeContent = FocusNode();
  late String _initialNoteContent;
  late String _initialNoteTitle;

  @override
  void initState() {
    super.initState();
    if (widget.note == null) {
      _focusNodeTitle.requestFocus();
    } else {
      _focusNodeContent.requestFocus();
    }
    _contentController = TextEditingController(text: widget.note?.content);
    _titleController = TextEditingController(text: widget.note?.title);
    _initialNoteContent = widget.note?.content ?? '';
    _initialNoteTitle = widget.note?.title ?? '';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _focusNodeTitle.dispose();
    _focusNodeContent.dispose();
    super.dispose();
  }

  void _saveNote({bool isAutoSave = false}) {
    final title = _titleController.text;
    final content = _contentController.text;
    if (isAutoSave &&
        content == _initialNoteContent &&
        title == _initialNoteTitle) {
      return;
    }
    if (content.isEmpty && title.isEmpty) {
      Get.back();
      Get.back();
      return;
    }

    if (widget.note == null) {
      noteController.addNote(title, content);
    } else {
      noteController.updateNote(widget.note!.id, title, content);
    }
    _initialNoteTitle = _titleController.text;
    _initialNoteContent = _contentController.text;
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
                                      widget.note!.id,
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
                TextFormField(
                  focusNode: _focusNodeTitle,
                  controller: _titleController,
                  textAlignVertical: TextAlignVertical.top,
                  style: Theme.of(context).textTheme.labelLarge,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(0),
                  ),
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(_focusNodeContent);
                  },
                  autocorrect: false,
                  enableSuggestions: false,
                ),
                Expanded(
                  child: TextFormField(
                    focusNode: _focusNodeContent,
                    controller: _contentController,
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(0),
                    ),
                    onChanged: (value) {
                      if (value.isEmpty) {
                        FocusScope.of(context).requestFocus(_focusNodeTitle);
                      }
                    },
                    autocorrect: false,
                    enableSuggestions: false,
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
