// This code will be dynamically loaded into a separate isolate

import 'dart:isolate';

void main(List<String> args, SendPort replyTo) {

  var dummy;

  // Emulate long running computations
  for (var i = 0; i < 40000000; ++i) {
    dummy= " $i";
}

replyTo.send("The second isolate believes that ${args[0]} is great investment!");

}