class QuoteModel {
  // Propriedades originais do JSON
  final String id;
  final String quoteText;
  final String quoteTextOriginal;
  final String author;
  final String workTitle;
  final String reference;
  final String translationNote;
  final String confidenceLevel;
  final String sourceUrl;
  final String suggestedDisplayText;
  final String reflection;
  final String imageUrl;
  final List<String> tags;

  const QuoteModel({
    required this.id,
    required this.quoteText,
    required this.quoteTextOriginal,
    required this.author,
    required this.workTitle,
    required this.reference,
    required this.translationNote,
    required this.confidenceLevel,
    required this.sourceUrl,
    required this.suggestedDisplayText,
    required this.reflection,
    required this.imageUrl,
    required this.tags,
  });

  // Getters para compatibilidade com a UI atual
  String get trecho => quoteText;

  String get livro {
    final parts = <String>[
      if (reference.trim().isNotEmpty) reference.trim(),
      if (author.trim().isNotEmpty) author.trim(),
    ];
    return parts.join('    ');
  }

  String get explicacao {
    if (reflection.trim().isNotEmpty) return reflection.trim();
    if (translationNote.trim().isNotEmpty) return translationNote.trim();
    return '';
  }

  String get backgroundImage => imageUrl;

  factory QuoteModel.fromMap(Map<String, dynamic> map) {
    String readString(String key, [String fallback = '']) {
      final value = map[key];
      if (value == null) return fallback;
      return value.toString().trim();
    }

    List<String> readStringList(String key) {
      final value = map[key];
      if (value is List) {
        return value.map((e) => e.toString()).toList();
      }
      return <String>[];
    }

    return QuoteModel(
      id: readString('id'),
      quoteText: readString('quote_text'),
      quoteTextOriginal: readString('quote_text_original'),
      author: readString('author'),
      workTitle: readString('work_title'),
      reference: readString('reference'),
      translationNote: readString('translation_note'),
      confidenceLevel: readString('confidence_level'),
      sourceUrl: readString('source_url'),
      suggestedDisplayText: readString('suggested_display_text'),
      reflection: readString(
        'reflection',
        readString('explicacao'),
      ),
      imageUrl: readString(
        'image_url',
        readString(
          'background_image',
          readString('display_url'),
        ),
      ),
      tags: readStringList('tags'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quote_text': quoteText,
      'quote_text_original': quoteTextOriginal,
      'author': author,
      'work_title': workTitle,
      'reference': reference,
      'translation_note': translationNote,
      'confidence_level': confidenceLevel,
      'source_url': sourceUrl,
      'suggested_display_text': suggestedDisplayText,
      'reflection': reflection,
      'image_url': imageUrl,
      'tags': tags,
    };
  }

  QuoteModel copyWith({
    String? id,
    String? quoteText,
    String? quoteTextOriginal,
    String? author,
    String? workTitle,
    String? reference,
    String? translationNote,
    String? confidenceLevel,
    String? sourceUrl,
    String? suggestedDisplayText,
    String? reflection,
    String? imageUrl,
    List<String>? tags,
  }) {
    return QuoteModel(
      id: id ?? this.id,
      quoteText: quoteText ?? this.quoteText,
      quoteTextOriginal: quoteTextOriginal ?? this.quoteTextOriginal,
      author: author ?? this.author,
      workTitle: workTitle ?? this.workTitle,
      reference: reference ?? this.reference,
      translationNote: translationNote ?? this.translationNote,
      confidenceLevel: confidenceLevel ?? this.confidenceLevel,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      suggestedDisplayText: suggestedDisplayText ?? this.suggestedDisplayText,
      reflection: reflection ?? this.reflection,
      imageUrl: imageUrl ?? this.imageUrl,
      tags: tags ?? this.tags,
    );
  }
}