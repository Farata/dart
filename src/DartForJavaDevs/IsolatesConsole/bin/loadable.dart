// This code will be dynamically loaded by spawnuri.dart

import 'dart:isolate';

void main(List<String> args, SendPort replyTo) {

    replyTo.send("loadable.dart says hello to ${args[0]}!" );

}