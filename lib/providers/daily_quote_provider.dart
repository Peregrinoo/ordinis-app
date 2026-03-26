import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:ordinis/data/models/quote_model.dart';
import 'package:ordinis/services/quote_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  // Variáveis para favoritos
  Set<String> _favoriteIds = <String>{};
  static const String _favoritesKey = 'favorite_quotes';


   /*
   * 1 - Puxar uma palavra aleatóriamente
   * 2 - Carregar o json geral das palavras e armazenar-las
   */

  Future<void> loadAllQuotes() async {
    SharedPreferences.setMockInitialValues({});
    _isLoading = true;
    _error = null;

    try {
      _allQuotes = await service.loadQuotes();
      print("Deus me ajude !!! ${allQuotes}");
      if (_allQuotes.isNotEmpty) {
        _selectedQuote = _allQuotes.first;
      }

      // Carregar favoritos salvos
      await _loadFavorites();

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

  // Métodos para favoritos
  Future<void> _loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesList = prefs.getStringList(_favoritesKey) ?? [];
      _favoriteIds = favoritesList.toSet();
    } catch (e) {
      debugPrint('Erro ao carregar favoritos: $e');
    }
  }

  Future<void> _saveFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_favoritesKey, _favoriteIds.toList());
    } catch (e) {
      debugPrint('Erro ao salvar favoritos: $e');
    }
  }

  Future<void> toggleFavorite(QuoteModel quote) async {
    if (_favoriteIds.contains(quote.id)) {
      _favoriteIds.remove(quote.id);
    } else {
      _favoriteIds.add(quote.id);
    }

    await _saveFavorites();
    notifyListeners();
  }

  bool isFavorite(String quoteId) {
    return _favoriteIds.contains(quoteId);
  }

  List<QuoteModel> get favoriteQuotes {
    return _allQuotes.where((quote) => _favoriteIds.contains(quote.id)).toList();
  }

  //Os getters fofos.
  List<QuoteModel> get allQuotes => _allQuotes;
  QuoteModel? get selectedQuote => _selectedQuote;
  bool get isLoading => _isLoading;
  String? get error => _error;


}
