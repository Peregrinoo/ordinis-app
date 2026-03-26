import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ordinis/data/models/quote_model.dart';
import 'package:ordinis/widgets/quotes/action_buttons.dart';

class QuoteCard extends StatelessWidget {
  final QuoteModel quote;
  final VoidCallback onShare;
  final VoidCallback onFavorite;
  final bool isFavorite;

  const QuoteCard({
    super.key,
    required this.quote,
    required this.onShare,
    required this.onFavorite,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = Colors.white.withOpacity(0.26);
    final surfaceColor = const Color(0xFFC8B79F).withOpacity(0.18);
    final textPrimary = const Color(0xFFF7F1E8);
    final textSecondary = const Color(0xFFE7DDD0);

    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(26),
            border: Border.all(
              color: borderColor,
              width: 1.1,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.10),
                Colors.white.withOpacity(0.04),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.10),
                blurRadius: 22,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '“${quote.trecho}”',
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 31,
                  height: 1.02,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.15,
                  color: textPrimary,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '${quote.reference}    ${quote.author}',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.4,
                  color: textSecondary.withOpacity(0.92),
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                quote.explicacao,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  height: 1.45,
                  fontWeight: FontWeight.w400,
                  color: textSecondary.withOpacity(0.96),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ActionCircleButton(
                    icon: isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    onTap: onFavorite,
                  ),
                  const SizedBox(width: 10),
                  ActionCircleButton(
                    icon: Icons.share_outlined,
                    onTap: onShare,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}