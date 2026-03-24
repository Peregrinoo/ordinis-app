import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:ordinis/data/models/quote_model.dart';

class QuoteService {
  Future<List<QuoteModel>> loadQuotes() async {
    final String jsonString =
    await rootBundle.loadString('assets/dataset.json');

    final List<dynamic> jsonList = jsonDecode(jsonString);

    return jsonList
        .map((item) => QuoteModel.fromMap(item as Map<String, dynamic>))
        .toList();
  }
}