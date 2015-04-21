import 'dart:html';
import 'dart:convert';
import 'package:stock_quote_web_json/stock.dart';
import 'package:stock_quote_web_json/stock_quote_generator.dart';

StockQuoteGenerator generator = new StockQuoteGenerator();

InputElement enteredSymbol;
SpanElement priceQuote;
UListElement listYesterdayHtml;
LIElement listItem;

void main() {

  enteredSymbol = querySelector("#enteredSymbol")
                  ..onChange.listen(showPrice);

  priceQuote = querySelector('#priceQuote');

  listYesterdayHtml = querySelector('#yesterdaysPrices');

  // Performing an AJAX call with HTTP GET
  HttpRequest.getString('data/stocks.json')
          .then(populateYesterdayPrices)
          .catchError((err) {
             listYesterdayHtml.innerHtml +=
                 '''<li>Error while retrieving JSON file with stocks:
                               ${err.target.responseText}</li>
                 ''';
  });
}

void populateYesterdayPrices(String responseText){

  List listOfStocks = JSON.decode(responseText);

  listOfStocks.forEach((stock){

    listItem = new LIElement()
      ..text= '''${stock['symbol']}:
           \$${stock['price'].toStringAsFixed(2)}
        ''';

    listYesterdayHtml.append(listItem);

  });

}

void showPrice(Event e){
  Stock stock = generator.getQuote(enteredSymbol.value);
  priceQuote.text = "\$" + stock.price.toStringAsFixed(2);
}


