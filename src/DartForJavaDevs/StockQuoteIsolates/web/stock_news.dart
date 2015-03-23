import 'dart:async';
import 'dart:isolate';

void main(List<String> args, SendPort sendPort){

  print("Time to buy $args[0]" );

  // Emulate an operation that takes 5 sec
  new Timer(new Duration(seconds:5), (){

    sendPort.send("Time to buy $args[0]" );


  });

}