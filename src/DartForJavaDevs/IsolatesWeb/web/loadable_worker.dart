// This code will be dynamically loaded

import 'dart:isolate';
import 'dart:math';

void main(List<String> args, SendPort replyTo) {

  var rand = new Random();

  var iterations = rand.nextInt(80000000);

  var dummy;

  // Emulate long running computations
  for (var i = 0; i < iterations; ++i) {
    dummy= " $i";
}

replyTo.send("${args[0]} is done, here's the result: $dummy");

}