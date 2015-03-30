import 'dart:html';
import  'dart:async';
import 'package:stock_quote_async_await/stock.dart';
import 'package:stock_quote_async_await/stock_quote_generator.dart';

StockQuoteGenerator generator = new StockQuoteGenerator();

InputElement enteredSymbol;
SpanElement priceQuote;
InputElement readButton;
DivElement log;

main() {

  enteredSymbol = querySelector("#enteredSymbol")
                  ..onChange.listen(showPrice);

  readButton = querySelector("#slowOperationButton")
               ..onClick.listen(clickHandler);

  priceQuote = querySelector('#priceQuote');

  log = querySelector("#log");
}

clickHandler(event) async {

   // Get some news on the entered stock

  log.innerHtml+="Calling slowOperation ${new DateTime.now()} <br>";

  var result = await slowOperation(enteredSymbol.value);

     log.innerHtml+="Awaiting is over!</br>";
     log.innerHtml+="$result ${new DateTime.now()}";

}

slowOperation(stockSymbol) {

  var completer = new Completer<String>();

  // Emulate a long running operation
  // by using Future.delayed constructor (the function will run in 10 sec)
  new Future.delayed(const Duration(seconds: 10), () {
    completer.complete("$stockSymbol is a great investment!"); // returns the String
  });                                                          // could add .catchError()

  return completer.future;

}

showPrice(event){
  Stock stock = generator.getQuote(enteredSymbol.value);
  priceQuote.text = "\$${stock.price.toStringAsFixed(2)}";
}


