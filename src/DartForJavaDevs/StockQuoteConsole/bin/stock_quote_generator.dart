// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import  'dart:math';
import 'package:args/args.dart';

List<String> supportedSymbols = ["AAPL", "MSFT", "IBM"];
Random rand = new Random();

ArgResults argResults;

String getQuote(String symbol){

  if(supportedSymbols.contains(symbol)){

     return rand.nextDouble().toString();
  } else{
      return "Invalid symbol $symbol. Use one of these ${supportedSymbols.toString()}" ;
  }
}


main(List<String> args) {

  final parser = new ArgParser();
  argResults = parser.parse(args);

  List<String> symbol = argResults.rest;

  print('The price of ${symbol[0]} is ${getQuote(symbol[0])}');

}
