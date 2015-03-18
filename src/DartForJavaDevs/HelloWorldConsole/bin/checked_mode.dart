/**
   Running in checked mode: dart --checked checked_mode.dart

   Running in runtime mode: dart checked_mode.dart
 */

main() {
  print('Adding numbers: ${add (2,3)}');
  print('Adding strings: ${add ("Hello ","World")}');
}

add (num a, num b){

  return a+b;
}
