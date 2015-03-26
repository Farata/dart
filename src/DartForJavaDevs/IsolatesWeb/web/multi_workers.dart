import 'dart:isolate';
import 'dart:async';
import 'dart:html';

main() {

  DivElement output = querySelector('#output');

  const NUMBER_OF_WORKERS = 4;

  for (var i = 0; i < NUMBER_OF_WORKERS; i++) {

    ReceivePort receivePort = new ReceivePort();

    Future<Isolate> remote = Isolate.spawnUri(
        Uri.parse("loadable_worker.dart"),
        ["Worker $i"],
        receivePort.sendPort);

    remote
    .then((_) => receivePort.first)
    .then((message) {
      output.innerHtml += "The main isolate got: $message <br>";

    });
  }
}
