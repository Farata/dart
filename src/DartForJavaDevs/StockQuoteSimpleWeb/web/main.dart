// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'package:stock_quote_simple_web/stock.dart';
import 'package:stock_quote_simple_web/stock_quote_generator.dart';

StockQuoteGenerator generator = new StockQuoteGenerator();

InputElement enteredSymbol;
LabelElement priceQuote;

void main() {

  enteredSymbol = querySelector("#enteredSymbol");

  enteredSymbol.onChange.listen(showPrice);

  priceQuote = querySelector('#priceQuote');

}

void showPrice(Event e){
  Stock stock = generator.getQuote(enteredSymbol.value);
  priceQuote.text = stock.price.toStringAsFixed(2);
}


