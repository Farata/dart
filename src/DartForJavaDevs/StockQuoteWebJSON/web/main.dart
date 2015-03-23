import 'dart:html';
import 'dart:convert';
import 'package:stock_quote_web_json/stock.dart';
import 'package:stock_quote_web_json/stock_quote_generator.dart';

StockQuoteGenerator generator = new StockQuoteGenerator();

InputElement enteredSymbol;
SpanElement priceQuote;

void main() {

  enteredSymbol = querySelector("#enteredSymbol")
                  ..onChange.listen(showPrice);

  priceQuote = querySelector('#priceQuote');


  HttpRequest.getString('data/stocks.json')
  .then(populateYesterdayPrices)
  .catchError((err) {
    print("Error while retrieving JSON file with stocks: ${err.target.responseText}");
  });
}

void populateYesterdayPrices(String responseText){

   List listOfStocks = JSON.decode(responseText);

   UListElement listYesterdayHtml = querySelector('#yesterdaysPrices');

    listOfStocks.forEach((stock){

       listYesterdayHtml.innerHtml +=
        '''<li>${stock['symbol']}:
           \$${stock['price'].toStringAsFixed(2)}</li>
        ''';
    });
    var i=1;
}

void showPrice(Event e){
  Stock stock = generator.getQuote(enteredSymbol.value);
  priceQuote.text = "\$" + stock.price.toStringAsFixed(2);
}


