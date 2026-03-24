import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:ordinis/data/models/quote_model.dart';
import 'package:ordinis/services/quote_service.dart';

class DailyQuoteProvider extends ChangeNotifier {
  // Caras importantes que vão nos ajudar....
  final QuoteService service;
  final Random _random = Random();

  DailyQuoteProvider({required this.service});

  // Variáveis de controle para nossa UI
  List<QuoteModel> _allQuotes = [];
  QuoteModel? _selectedQuote;
  bool _isLoading = false;
  String? _error;


   /*
   * 1 - Puxar uma palavra aleatóriamente
   * 2 - Carregar o json geral das palavras e armazenar-las
   */

  Future<void> loadAllQuotes() async {
    _isLoading = true;
    _error = null;

    try {
      _allQuotes = await service.loadQuotes();
      print("Deus me ajude !!! ${allQuotes}");
      if (_allQuotes.isNotEmpty) {
        _selectedQuote = _allQuotes.first;
      }

      notifyListeners();
    } catch (e, s) {
      debugPrint('Erro em loadAllQuotes: $e');
      debugPrintStack(stackTrace: s);
      _error = 'Não foi possível carregar as citações.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void getRandomQuote() {
    if (_allQuotes.isEmpty) return;

    final int index = _random.nextInt(_allQuotes.length);
    _selectedQuote = _allQuotes[index];
    notifyListeners();
  }

  //Os getters fofos.
  List<QuoteModel> get allQuotes => _allQuotes;
  QuoteModel? get selectedQuote => _selectedQuote;
  bool get isLoading => _isLoading;
  String? get error => _error;


}