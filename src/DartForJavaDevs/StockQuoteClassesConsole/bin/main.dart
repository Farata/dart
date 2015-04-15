library stock_quote;

import 'dart:math';
import 'dart:io';
import 'package:args/args.dart';

part "stock.dart";
part "stock_quote_generator.dart";

main(List<String> args) {

  ArgResults argResults;

  final parser = new ArgParser();
  argResults = parser.parse(args);

  List<String> symbols = argResults.rest;

  if (symbols.isEmpty){
    print ("Please provide a stock symbol as command line arg");
    exit(-1);
  }

  symbols.forEach((symbol) {

    Stock stock = StockQuoteGenerator.getQuote(symbol);
    if (stock.price == null) {
      print("Invalid stock $symbol. Price quotes are available only for ${StockQuoteGenerator._supportedSymbols}");
    } else {
      print('The price of ${stock.symbol} is \$${stock.price}');
    }

  }
  );




}
