// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';
import 'package:deferred_library/some_lib.dart' deferred as some_lib;

main() async {
  final output = querySelector('#output');
  output.text ='Your Dart app is running.';

  await new Future.delayed(const Duration(seconds: 3));
  await some_lib.loadLibrary();
  output.innerHtml += some_lib.toUpper('<br/>Deferred library is loaded');
}
