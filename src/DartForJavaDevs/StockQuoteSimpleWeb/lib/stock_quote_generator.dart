library stock_quote;

import 'dart:math';
import 'package:stock_quote_simple_web/stock.dart';

class StockQuoteGenerator {

  List<String> _supportedSymbols = ["AAPL", "MSFT", "IBM"];
   Random rand = new Random();

   Stock getQuote(String symbol) {

    Stock stock = new Stock(symbol);
    stock.symbol = symbol;

    if (_supportedSymbols.contains(symbol)) {

      stock.price = rand.nextDouble();
    }
      return stock;
    }

    List<String> get symbols => _supportedSymbols;


}