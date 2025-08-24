// class NoteItemModel {
//   String? id;
//   String? title;
//   String? content;
//   String? createdAt;
//   String? lastEdited;

//   NoteItemModel({
//     this.id,
//     this.title,
//     this.content,
//     this.createdAt,
//     this.lastEdited,
//   });

//   NoteItemModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     content = json['content'];
//     createdAt = json['createdAt'];
//     lastEdited = null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['title'] = title;
//     data['content'] = content;
//     data['createdAt'] = createdAt;
//     if (lastEdited != null) {
//       data['lastEdited'] = lastEdited;
//     }
//     return data;
//   }

//   NoteItemModel copyWith({String? lastEdited}) {
//     return NoteItemModel(
//       id: id,
//       title: title,
//       content: content,
//       createdAt: createdAt,
//       lastEdited: lastEdited ?? this.lastEdited,
//     );
//   }
// }
