import 'dart:async';
import 'dart:isolate';

main() {

  ReceivePort mainIsolateReceivePort = new ReceivePort();

  Future<Isolate> stockNewsIsolate =
                         Isolate.spawn(getStockNews,mainIsolateReceivePort.sendPort );

  stockNewsIsolate
      .then((_)=> mainIsolateReceivePort.first)   // get the stock isolate's port
      .then((sendPort) {
             sendReceive(sendPort, "IBM")
             .then((msg) {

               print("The main isolate received the news at ${new DateTime.now()}: $msg");

               return;
            })
            .catchError((err) => print("Could't spawn stock isolate $err"));
       });

  print("Spawned Market News isolate at ${new DateTime.now()}");

}

Future sendReceive(SendPort port, msg) {
  ReceivePort recv = new ReceivePort();
  port.send([msg, recv.sendPort]);
  return recv.first;
}

// this function will run in a separate isolate
getStockNews(SendPort sendPort){

  var stockNewsReceiverPort = new ReceivePort();  // to get msg from the main isolate

  sendPort.send(stockNewsReceiverPort.sendPort);  // let the main isolate know the port

  stockNewsReceiverPort.listen((message){
       var stockSymbol = message[0];
       print("The stock news isolate is getting the $stockSymbol news...");

       SendPort replyTo = message[1];

      // Emulate an operation that takes 5 sec; then send the result
       new Timer(new Duration(seconds:5), (){
          replyTo.send("Time to buy $stockSymbol!" );

       });
  });
}