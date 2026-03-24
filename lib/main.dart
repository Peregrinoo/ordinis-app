import 'package:flutter/material.dart';
import 'package:ordinis/providers/daily_quote_provider.dart';
import 'package:ordinis/services/quote_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => DailyQuoteProvider(service: QuoteService()))
    ], child: const MinhaAplicacao(),)
  );

}

class MinhaAplicacao extends StatelessWidget {
  const MinhaAplicacao({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ordinis - Santo agostinho",
      home: ,
    );
  }
}
