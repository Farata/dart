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

  log.innerHtml+="Calling two slowOperations (3 sec and 7 sec) ${new DateTime.now()} <br>";

  var result1 = await slowOperation1(enteredSymbol.value);  // 7 sec

  var result2 = await slowOperation2(enteredSymbol.value);  // 3 sec

  log.innerHtml+="Awaiting is over!</br>";      // total time 10 sec

  log.innerHtml+="$result1 ${new DateTime.now()}  <br>";
  log.innerHtml+="$result2 ${new DateTime.now()}  <br>";

}

slowOperation1(stockSymbol) async {

  var completer = new Completer<String>();

  // Emulate a long running operation
  // by using Future.delayed constructor (the function will run in 7 sec)
  new Future.delayed(const Duration(seconds: 7), () {
    completer.complete("$stockSymbol is a great investment!"); // returns the String
  });                                                          // could add .catchError()

  return completer.future;

}

slowOperation2(stockSymbol) {

  var completer = new Completer<String>();

  // Emulate a long running operation
  // by using Future.delayed constructor (the function will run in 3 sec)
  new Future.delayed(const Duration(seconds: 3), () {
    completer.complete(" The targe price of $stockSymbol is a 200!");
  });

  return completer.future;

}



showPrice(event){
  Stock stock = generator.getQuote(enteredSymbol.value);
  priceQuote.text = "\$${stock.price.toStringAsFixed(2)}";
}


