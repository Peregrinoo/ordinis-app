import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ordinis/providers/daily_quote_provider.dart';
import 'package:ordinis/widgets/quotes/quotes_card.dart';
import 'package:ordinis/data/models/quote_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

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
    final favoriteQuotes = provider.favoriteQuotes;

    return Scaffold(
      backgroundColor: const Color(0xFF2A211B),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFFF7F1E8),
            size: 22,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Favoritos',
          style: GoogleFonts.cormorantGaramond(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFF7F1E8),
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
      ),
      body: favoriteQuotes.isEmpty
          ? _buildEmptyState()
          : _buildFavoritesList(favoriteQuotes, provider),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFC8B79F).withOpacity(0.15),
                border: Border.all(
                  color: const Color(0xFFC8B79F).withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              child: Icon(
                Icons.favorite_border,
                size: 48,
                color: const Color(0xFFC8B79F).withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Nenhum favorito ainda',
              style: GoogleFonts.cormorantGaramond(
                fontSize: 26,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFF7F1E8),
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Toque no coração ao lado de uma frase\npara adicioná-la aos seus favoritos',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: const Color(0xFFE7DDD0).withOpacity(0.8),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoritesList(List<QuoteModel> favoriteQuotes, DailyQuoteProvider provider) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      itemCount: favoriteQuotes.length,
      itemBuilder: (context, index) {
        final quote = favoriteQuotes[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: QuoteCard(
            quote: quote,
            isFavorite: true,
            onShare: () => _shareQuote(quote),
            onFavorite: () => provider.toggleFavorite(quote),
          ),
        );
      },
    );
  }
}
