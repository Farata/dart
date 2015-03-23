import 'dart:html';
import 'dart:async';
import 'dart:isolate';
import 'package:stock_quote_isolates/stock.dart';
import 'package:stock_quote_isolates/stock_quote_generator.dart';

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

  ReceivePort receivePort = new ReceivePort();

  Future<Isolate> remote = Isolate.spawnUri(Uri.parse("stock_news.dart"),["AAPL"],receivePort.sendPort );

  remote.then((_) => receivePort.first)
        .then((result){
             log.innerHtml+="$result ${new DateTime.now()}";
        });


  // The next line is executed before future.then()
  log.innerHtml+="Spawned the stock_news isolate ${new DateTime.now()} <br>";
}



showPrice(event){
  Stock stock = generator.getQuote(enteredSymbol.value);
  priceQuote.text = "\$${stock.price.toStringAsFixed(2)}";
}


