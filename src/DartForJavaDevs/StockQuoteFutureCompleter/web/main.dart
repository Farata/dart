import 'dart:html';
import  'dart:async';
import 'package:stock_quote_future_completer/stock.dart';
import 'package:stock_quote_future_completer/stock_quote_generator.dart';

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

clickHandler(event){

   // Get some news on the entered stock
   var future = slowOperation(enteredSymbol.value);


   // The clickHandler returns without waiting
   future.then((result){
                  log.innerHtml+="I'm back from the future!</br>";
                  log.innerHtml+="$result ${new DateTime.now()}";
   });

   // The next line is executed before the above future.then()
   log.innerHtml+="Called slowOperation ${new DateTime.now()} <br>";
}

slowOperation(stockSymbol){


  // Emulate a long running operation
  // by using Future.delayed constructor (the function will run in 10 sec)
  return new Future.delayed(const Duration(seconds: 10), () {
     return "$stockSymbol is a great investment!"; // returns the String
  });                                                          // could add .catchError()

}

showPrice(event){
  Stock stock = generator.getQuote(enteredSymbol.value);
  priceQuote.text = "\$${stock.price.toStringAsFixed(2)}";
}


