import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ordinis/providers/daily_quote_provider.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  static const Color _backgroundTop = Color(0xFFEBE5D2);
  static const Color _backgroundBottom = Color(0xFFFFD7AB);
  static const Color _logoColor = Color(0xFFC8A764);
  static const Color _textColor = Color(0xFF111111);

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await context.read<DailyQuoteProvider>().loadAllQuotes();

    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              _backgroundTop,
              _backgroundBottom,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    width: 190,
                  ),
                  SizedBox(height: 28),
                  Text(
                    'ORDINIS',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 48,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 3.5,
                      color: _textColor,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Ordenando o amor, um dia por vez',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cormorant(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      color: _textColor.withOpacity(0.92),
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
