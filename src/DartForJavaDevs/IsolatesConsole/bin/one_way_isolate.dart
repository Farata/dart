import 'dart:async';
import 'dart:isolate';

main() {

  ReceivePort marketNewsReceivePort = new ReceivePort()
    ..listen((result){
    print("$result ${new DateTime.now()}");
  });


  Isolate.spawn(getMarketNews,marketNewsReceivePort.sendPort );
  print("Spawned Market News isolate ${new DateTime.now()}");

}

// A function to run in a separate isolate
getMarketNews(SendPort sendPort){


  var dummy;

  // Emulate long computations
  for (var i = 0; i < 100000000; ++i) {
    dummy="a $i";
  }

  sendPort.send("Market news: Time to buy!" );


}