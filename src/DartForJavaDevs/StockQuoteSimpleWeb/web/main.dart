// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'package:stock_quote_simple_web/stock.dart';
import 'package:stock_quote_simple_web/stock_quote_generator.dart';

StockQuoteGenerator generator = new StockQuoteGenerator();

InputElement enteredSymbol;
SpanElement priceQuote;


void main() {

  enteredSymbol = querySelector("#enteredSymbol")
                  ..onChange.listen(showPrice);

  priceQuote = querySelector('#priceQuote');

  querySelector('#abutton') // Get an object.
    ..text = 'Confirm'   // Use its members.
    ..classes.add('important')
    ..onClick.listen((e) => window.alert('Confirmed!'));



}

void showPrice(Event e){
  Stock stock = generator.getQuote(enteredSymbol.value);
  priceQuote.text = "\$${stock.price.toStringAsFixed(2)}";
}


