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
  final List<String> tags;

  // Propriedades para compatibilidade com a UI existente
  final String trecho;
  final String livro;
  final String explicacao;
  final String backgroundImage;

  // Construtor da classe
  QuoteModel({
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
    required this.tags,
    required this.trecho,
    required this.livro,
    required this.explicacao,
    required this.backgroundImage,
  });

  factory QuoteModel.fromMap(Map<String, dynamic> map) {
    // Extrair dados do JSON
    final id = map['id'] ?? '';
    final quoteText = map['quote_text'] ?? '';
    final quoteTextOriginal = map['quote_text_original'] ?? '';
    final author = map['author'] ?? '';
    final workTitle = map['work_title'] ?? '';
    final reference = map['reference'] ?? '';
    final translationNote = map['translation_note'] ?? '';
    final confidenceLevel = map['confidence_level'] ?? '';
    final sourceUrl = map['source_url'] ?? '';
    final suggestedDisplayText = map['suggested_display_text'] ?? '';
    final imageURL = map["image_url"] ?? '';
    final tags = List<String>.from(map['tags'] ?? []);

    // Mapear para propriedades da UI existente
    final trecho = quoteText;
    final livro = workTitle.isNotEmpty && author.isNotEmpty 
        ? '$workTitle - $author' 
        : (author.isNotEmpty ? author : workTitle);
    final explicacao = translationNote.isNotEmpty 
        ? translationNote 
        : (reference.isNotEmpty ? 'Referência: $reference' : '');
    final backgroundImage = imageURL;

    return QuoteModel(
      id: id,
      quoteText: quoteText,
      quoteTextOriginal: quoteTextOriginal,
      author: author,
      workTitle: workTitle,
      reference: reference,
      translationNote: translationNote,
      confidenceLevel: confidenceLevel,
      sourceUrl: sourceUrl,
      suggestedDisplayText: suggestedDisplayText,
      tags: tags,
      trecho: trecho,
      livro: livro,
      explicacao: explicacao,
      backgroundImage: backgroundImage,
    );
  }

  QuoteModel copyWith({
    String? backgroundImage,
  }) {
    return QuoteModel(
      id: id,
      quoteText: quoteText,
      quoteTextOriginal: quoteTextOriginal,
      author: author,
      workTitle: workTitle,
      reference: reference,
      translationNote: translationNote,
      confidenceLevel: confidenceLevel,
      sourceUrl: sourceUrl,
      suggestedDisplayText: suggestedDisplayText,
      tags: tags,
      trecho: trecho,
      livro: livro,
      explicacao: explicacao,
      backgroundImage: backgroundImage ?? this.backgroundImage,
    );
  }
}
