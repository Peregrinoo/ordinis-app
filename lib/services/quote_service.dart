import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:ordinis/data/models/quote_model.dart';

class QuoteService {
  Future<List<QuoteModel>> loadQuotes() async {
    final String jsonString = await rootBundle.loadString('assets/dataset.json');
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;

    final List<dynamic> quotesList = (jsonMap['quotes'] as List<dynamic>? ?? []);
    final List<dynamic> imagesList = (jsonMap['images'] as List<dynamic>? ?? []);

    final List<String> imageUrls = imagesList
        .map((item) => _extractImageUrl(item))
        .where((url) => url.isNotEmpty)
        .toList();

    return List<QuoteModel>.generate(quotesList.length, (index) {
      final quoteMap = Map<String, dynamic>.from(quotesList[index] as Map);
      final quote = QuoteModel.fromMap(quoteMap);

      // 1) usa a imagem da própria quote, se existir
      // 2) se não existir, usa uma da lista geral de images
      final resolvedImage = quote.imageUrl.isNotEmpty
          ? quote.imageUrl
          : _getImageForIndex(imageUrls, index);

      return quote.copyWith(
        imageUrl: resolvedImage,
      );
    });
  }

  String _extractImageUrl(dynamic item) {
    if (item is! Map) return '';

    final map = Map<String, dynamic>.from(item);

    return (map['display_url'] ??
        map['thumbnail_url'] ??
        map['download_url'] ??
        map['image_url'] ??
        map['background_image'] ??
        '')
        .toString()
        .trim();
  }

  String _getImageForIndex(List<String> images, int index) {
    if (images.isEmpty) return '';
    return images[index % images.length];
  }
}