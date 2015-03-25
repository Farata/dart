import 'dart:isolate';
import 'dart:math';

main() {
  int counter = 0;

  int coresCompleted = 0;

  const NUMBER_OF_CORES = 4;

  ReceivePort receivePort = new ReceivePort();

  receivePort.listen((msg) {

    if (msg is SendPort) {

      msg.send("CPU CORE ${counter++}");

    } else {

      print(msg);
      coresCompleted++;

      if (coresCompleted == NUMBER_OF_CORES) {
        receivePort.close();
      }
    }

  });

  for (var i = 0; i < NUMBER_OF_CORES; i++) {
    Isolate.spawn(keepTheCoreBusy, receivePort.sendPort);
  }
  print("The main isolate is finished");
}


keepTheCoreBusy(SendPort sendPort) {

  ReceivePort receivePort = new ReceivePort();

  sendPort.send(receivePort.sendPort); // will data from main isolate via this port

  receivePort.listen((msg) {
    var rand = new Random();

    var iterations = rand.nextInt(90000000);

    var dummy;

    // Emulate long running computations
    for (var i = 0; i < iterations; ++i) {
        dummy="a $i";
    }

    sendPort.send("$msg: here's the dummy: $dummy");


    receivePort.close();

  });
}