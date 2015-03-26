import 'dart:async';
import 'dart:isolate';

main() {
  var recievingPort = new ReceivePort();
  Future<Isolate> remote = Isolate.spawnUri(
                              Uri.parse("loadable.dart"),
                              ["John Smith"],
                              recievingPort.sendPort);

  remote
        .then((_) => recievingPort.first)
        .then((message) {
           print("The main isolate got: $message");
        });
}
