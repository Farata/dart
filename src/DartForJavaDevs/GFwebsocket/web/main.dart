// Copyright (c) 2015, yfain11. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';

main() {

  var output = querySelector('#output');

  WebSocket ws = new WebSocket('ws://localhost:8080/GlassfishWebsocketDart_war_exploded/clock');

  ws.onOpen.listen((event){

    output.text = "Connected";

  });

  ws.onMessage.listen((event){

    output.text = event.data;

  });

}