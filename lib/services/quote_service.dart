import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:ordinis/data/models/quote_model.dart';

class QuoteService {
  final Random _random = Random();

  Future<List<QuoteModel>> loadQuotes() async {
    final String jsonString =
    await rootBundle.loadString('assets/dataset.json');

    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    final List<dynamic> quotesList = jsonMap['quotes'] as List<dynamic>;
    final List<dynamic> imagesList = jsonMap['images'] as List<dynamic>;

    // 🔥 Extrai só as URLs
    final List<String> imageUrls = imagesList
        .map((img) => img['display_url'] as String)
        .toList();

    // 🔥 Monta as quotes já com imagem
    return quotesList.map((item) {
      final quote =
      QuoteModel.fromMap(item as Map<String, dynamic>);

      final image = _getRandomImage(imageUrls);

      return quote.copyWith(
        backgroundImage: image,
      );
    }).toList();
  }

  String _getRandomImage(List<String> images) {
    if (images.isEmpty) return '';
    return images[_random.nextInt(images.length)];
  }
}