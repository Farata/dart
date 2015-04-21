import 'dart:html';
import 'dart:convert';
import  'dart:async';
import 'dart:isolate';
import 'package:stock_quote_async_await/stock.dart';
import 'package:stock_quote_async_await/stock_quote_generator.dart';

StockQuoteGenerator generator = new StockQuoteGenerator();

InputElement enteredSymbol;
SpanElement priceQuote;
InputElement asyncLoopButton;
InputElement asyncHttpButton;
InputElement isolateLoopButton;
DivElement log;
DivElement listYesterdayDiv;

main() {

  // DOM elements
  enteredSymbol = querySelector("#enteredSymbol")
                  ..onChange.listen(symbolInputHandler);

  priceQuote = querySelector('#priceQuote');

  log = querySelector("#log");

  // Buttons' handlers

  asyncLoopButton = querySelector("#asyncLoopButton")
               ..onClick.listen(asyncLoopButtonHandler);

  isolateLoopButton = querySelector("#isolateLoopButton")
    ..onClick.listen(isolateLoopButtonHandler);


  asyncHttpButton = querySelector("#asyncHttpButton")
    ..onClick.listen(asyncButtonHandler);

}


symbolInputHandler(event){
  Stock stock = generator.getQuote(enteredSymbol.value);
  priceQuote.text = "\$${stock.price.toStringAsFixed(2)}";
}

asyncLoopButtonHandler(event) async {

   // Get some news on the entered stock

  log.innerHtml+="Runing a slow loop in async mode ${new DateTime.now()} <br>";

  var result1 = await slowLoopWithAsync(enteredSymbol.value);

  log.innerHtml+="$result1 ${new DateTime.now()}  <br>";

}

slowLoopWithAsync(stockSymbol) async {

  // Emulate a long running operation with the loop
  // This freezes the GUI
  var dummy;

  for (var i = 0; i < 40000000; ++i) {
    dummy="a $i";
  }

  return "$stockSymbol is a great investment!"; // returns the String
}

isolateLoopButtonHandler(event) async {

  log.innerHtml+="<br>Spawning an isolate ${new DateTime.now()} <br>";

  ReceivePort receivePort = new ReceivePort();

  Future<Isolate> remote = Isolate.spawnUri(
      Uri.parse("loadable_worker.dart"),
      [enteredSymbol.value],
      receivePort.sendPort);

  remote
  .then((_) => receivePort.first)
  .then((message) {
    log.innerHtml += "The main isolate got: $message <br>";
  });
}


asyncButtonHandler(event) async {

  // Performing an AJAX call with HTTP GET
  listYesterdayDiv = querySelector('#yesterdaysPricesDiv');

  HttpRequest.getString('data/stocks.json')
  .then(populateYesterdayPrices)
  .catchError((err) {
    listYesterdayDiv.innerHtml +=
    '''<h2>Error while retrieving JSON file with stocks:
                               ${err.target.responseText}</h2>
                 ''';

  });
}

void populateYesterdayPrices(String responseText){


  listYesterdayDiv.append(new Element.html("<h2>Yesterday's Prices</h2>"));

  UListElement listYesterdayUL = new Element.ul();  // create an unordered list

  listYesterdayDiv.append(listYesterdayUL);

  LIElement listItem;

  List listOfStocks = JSON.decode(responseText);

  listOfStocks.forEach((stock){

    listItem = new LIElement()
               ..text= '''${stock['symbol']}::
           \$${stock['price'].toStringAsFixed(2)}
        ''';

    listYesterdayUL.append(listItem);

  });
}



