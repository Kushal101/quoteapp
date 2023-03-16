final String tableNotes = 'notes';

class QuoteFields {
  static final List<String> values = [
    /// Add all fields
    id, isImportant, tag, title, quotes, time
  ];

  static final String id = '_id';
  static final String isImportant = 'isImportant';
  static final String tag = 'tag';
  static final String title = 'title';
  static final String quotes = 'quotes';
  static final String time = 'time';
}

class Note {
  final int? id;
  final bool isImportant;
  final String tag;
  final String title;
  final String quotes;
  final DateTime createdTime;

  const Note({
    this.id,
    required this.isImportant,
    required this.tag,
    required this.title,
    required this.quotes,
    required this.createdTime,
  });

  Note copy({
    int? id,
    bool? isImportant,
    int? number,
    String? title,
    String? description,
    DateTime? createdTime,
  }) =>
      Note(
        id: id ?? this.id,
        isImportant: isImportant ?? this.isImportant,
        tag: tag ?? this.tag,
        title: title ?? this.title,
        quotes: description ?? this.quotes,
        createdTime: createdTime ?? this.createdTime,
      );

  static Note fromJson(Map<String, Object?> json) => Note(
    id: json[QuoteFields.id] as int?,
    isImportant: json[QuoteFields.isImportant] == 1,
    tag: json[QuoteFields.tag] as String,
    title: json[QuoteFields.title] as String,
    quotes: json[QuoteFields.quotes] as String,
    createdTime: DateTime.parse(json[QuoteFields.time] as String),
  );

  Map<String, Object?> toJson() => {
    QuoteFields.id: id,
    QuoteFields.title: title,
      QuoteFields.isImportant: isImportant ? 1 : 0,
    QuoteFields.tag: tag,
    QuoteFields.quotes: quotes,
    QuoteFields.time: createdTime.toIso8601String(),
  };
}
