class Note {
  int? id;
  String title;
  String content;
  String date; // store as formatted string for simplicity

  Note({
    this.id,
    required this.title,
    required this.content,
    required this.date,
  });

  // Convert Note -> Map for DB insert/update
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'title': title,
      'content': content,
      'date': date,
    };
    if (id != null) map['id'] = id;
    return map;
  }

  // Create Note from DB Map
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as int?,
      title: map['title'] as String? ?? '',
      content: map['content'] as String? ?? '',
      date: map['date'] as String? ?? '',
    );
  }
}