// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:convert';
import 'package:stock_quote_web_json/stock.dart';
import 'package:stock_quote_web_json/stock_quote_generator.dart';

StockQuoteGenerator generator = new StockQuoteGenerator();

InputElement enteredSymbol;
LabelElement priceQuote;

void main() {

  enteredSymbol = querySelector("#enteredSymbol");

  enteredSymbol.onChange.listen(showPrice);

  priceQuote = querySelector('#priceQuote');


  var list_el = querySelector('#yesterdaysPrices');

  HttpRequest.getString('data/stocks111.json')
             .then(populateYesterdayPrices)
             .catchError((Error err) {
                 print(err.toString());
              });

  doStuff()
     .then(callbackForSuccess)
     .catchError(callBackForError);

}

void callbackForSuccess() {
  //...
}

void callbackForError(Error error){
  // ...
}

void populateYesterdayPrices(String responseText){

    var list = JSON.decode(responseText);
    var i=1;
}


void showPrice(Event e){
  Stock stock = generator.getQuote(enteredSymbol.value);
  priceQuote.text = stock.price.toString();
}


