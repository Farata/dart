import 'dart:html';
import  'dart:async';
import 'package:stock_quote_simple_web/stock.dart';
import 'package:stock_quote_simple_web/stock_quote_generator.dart';

StockQuoteGenerator generator = new StockQuoteGenerator();

InputElement enteredSymbol;
SpanElement priceQuote;
InputElement readButton;
DivElement log;

main() {

  enteredSymbol = querySelector("#enteredSymbol");
  enteredSymbol.onChange.listen(showPrice);

  readButton = querySelector("#slowOperationButton");
  readButton.onClick.listen(clickHandler);

  priceQuote = querySelector('#priceQuote');

  log = querySelector("#log");
}

clickHandler(event){

   // Get some news on the entered stock
   var future = slowOperation(enteredSymbol.value);

   log.innerHtml+="Called slowOperation ${new DateTime.now()} <br>";

   // The clickHandler returns without waiting
   future.then((result){
     log.innerHtml+="I'm back from the future!</br>";
     log.innerHtml+="$result ${new DateTime.now()}";

   });
}

slowOperation(stockSymbol){
  var completer = new Completer<String>();

  // Emulate an operation that takes 10 sec
  new Timer(new Duration(seconds:10), (){
    completer.complete("$stockSymbol is a great investment!" ); // return the String
  });

  return completer.future;
}

showPrice(event){
  Stock stock = generator.getQuote(enteredSymbol.value);
  priceQuote.text = "\$${stock.price.toStringAsFixed(2)}";
}


