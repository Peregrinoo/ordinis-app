import 'package:flutter/material.dart';
import 'package:ordinis/widgets/quotes/quotes_card.dart';
import 'package:provider/provider.dart';
import 'package:ordinis/data/models/quote_model.dart';
import 'package:ordinis/providers/daily_quote_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:ui';

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

   // final isFavorite = provider.isFavorite(currentQuote.id);
    final isFavorite = true;
    return Scaffold(
      extendBody: true,
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

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 18,
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: QuoteCard(
                      quote: quote,
                      onShare: () {
                        print("Deus me ajude a implementar !");
                        },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _FavoritesDock(
        isFavorite: isFavorite,
        onOpenFavorites: () {
          Navigator.pushNamed(context, '/favorites');
        },
        onToggleFavorite: () {
          print("Deus me ajude !!");
        },
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

class _FavoritesDock extends StatelessWidget {
  final VoidCallback onOpenFavorites;
  final VoidCallback onToggleFavorite;
  final bool isFavorite;

  const _FavoritesDock({
    required this.onOpenFavorites,
    required this.onToggleFavorite,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFE8DFD1).withOpacity(0.72),
            borderRadius: BorderRadius.circular(26),
            border: Border.all(
              color: Colors.white.withOpacity(0.35),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _DockButton(
                icon: Icons.collections_bookmark_outlined,
                label: 'Salvas',
                onTap: onOpenFavorites,
              ),
              const SizedBox(width: 10),
              _DockButton(
                icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                label: isFavorite ? 'Salvo' : 'Salvar',
                onTap: onToggleFavorite,
                isActive: isFavorite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DockButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isActive;

  const _DockButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final background = isActive
        ? const Color(0xFFC8A96A).withOpacity(0.18)
        : Colors.white.withOpacity(0.16);

    final border = isActive
        ? const Color(0xFFC8A96A).withOpacity(0.45)
        : Colors.white.withOpacity(0.28);

    final foreground = isActive
        ? const Color(0xFF6E4F1F)
        : const Color(0xFF3A2E24);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: foreground),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: foreground,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}