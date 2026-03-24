import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ordinis/providers/daily_quote_provider.dart';
import 'package:ordinis/screens/splash-screen/splash_screen.dart';
import 'package:ordinis/services/quote_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DailyQuoteProvider(
            service: QuoteService(),
          ),
        ),
      ],
      child: const MinhaAplicacao(),
    ),
  );
}

class MinhaAplicacao extends StatelessWidget {
  const MinhaAplicacao({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ordinis - Santo Agostinho',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEBE5D2),
      ),
      home: const SplashPage(),
    );
  }
}
