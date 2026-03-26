import 'package:flutter/material.dart';
import 'package:ordinis/widgets/quotes/quotes_card.dart';
import 'package:provider/provider.dart';
import 'package:ordinis/providers/daily_quote_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share_plus/share_plus.dart';

import '../../data/models/quote_model.dart';

class QuotesScreen extends StatefulWidget {
  const QuotesScreen({super.key});

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  static const int _initialPage = 10000;
  late final PageController _pageController;

  int _currentPage = _initialPage;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _initialPage,
      viewportFraction: 0.92,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int _realIndex(int index, int length) {
    if (length == 0) return 0;
    return index % length;
  }

  void _shareQuote(QuoteModel quote) {
    final shareText = StringBuffer();

    // Adicionar a frase
    shareText.writeln('"${quote.trecho}"');
    shareText.writeln();

    // Adicionar autor e referência
    if (quote.author.isNotEmpty) {
      shareText.write('— ${quote.author}');
      if (quote.reference.isNotEmpty) {
        shareText.write(', ${quote.reference}');
      }
      shareText.writeln();
    } else if (quote.reference.isNotEmpty) {
      shareText.writeln('— ${quote.reference}');
    }

    shareText.writeln();
    shareText.write('Compartilhado via Ordinis');

    Share.share(shareText.toString());
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DailyQuoteProvider>();

    if (provider.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (provider.allQuotes.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('Nenhuma frase encontrada.')),
      );
    }

    final quotes = provider.allQuotes;
    final currentIndex = _realIndex(_currentPage, quotes.length);
    final currentQuote = quotes[currentIndex];

    final isFavorite = provider.isFavorite(currentQuote.id);

    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFE8DFD1),
        foregroundColor: const Color(0xFF3A2E24),
        elevation: 6,
        onPressed: () {
          Navigator.pushNamed(context, '/favorites');
        },
        child: const Icon(Icons.favorite_outline),
      ),
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: _BackgroundImage(
              key: ValueKey(currentQuote.backgroundImage),
              imageUrl: currentQuote.backgroundImage,
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.28),
          ),
          SafeArea(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (context, index) {
                final quote = quotes[_realIndex(index, quotes.length)];
                final pageIsFavorite =
                _realIndex(index, quotes.length) == currentIndex
                    ? isFavorite
                    : false;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 18,
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: QuoteCard(
                      quote: quote,
                      isFavorite: pageIsFavorite,
                      onShare: () {
                        _shareQuote(quote);
                      },
                      onFavorite: () {
                        provider.toggleFavorite(quote);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _BackgroundImage extends StatelessWidget {
  final String imageUrl;

  const _BackgroundImage({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: const Color(0xFF2A211B),
        ),
        errorWidget: (context, url, error) => Container(
          color: const Color(0xFF2A211B),
          child: const Center(
            child: Icon(
              Icons.broken_image_outlined,
              color: Colors.white,
              size: 38,
            ),
          ),
        ),
      ),
    );
  }
}
