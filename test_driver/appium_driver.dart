import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';

class AppiumDriver {
  FlutterDriver flutterDriver;
  HttpServer server;

  Future<void> start() async {
    server = await _setupServer();
    await _setupFlutter();

    await for (var request in server) {
      if (request.uri.toString() == '/hub/wd/tap') {
        SerializableFinder add = find.bySemanticsLabel('add the number');
        await flutterDriver.tap(add);

        returnResponse(request.response, '{"value": true}');
      } else if (request.uri.toString() == '/hub/wd/source') {
        RenderTree renderTree = await flutterDriver.getRenderTree();
        returnResponse(request.response,
            '{"value": ${renderTree.toJson()}');
      } else {
        returnResponse(request.response, '{"value": false,'
            '"error": "No matched value",'
            '"message": "no url ${request.uri}"}');
      }
    }
  }

  /// Returns a response to the response
  void returnResponse(HttpResponse response, String message) {
    response.headers.contentType
    = new ContentType('application', 'json', charset: 'utf-8');

    response.write(message);
    response.close();
  }

  Future<HttpServer> _setupServer() async {
    return await HttpServer.bind('localhost', 8080);
  }

  Future<void> _setupFlutter() async {
    flutterDriver = await FlutterDriver.connect();

    flutterDriver.setSemantics(true);
    flutterDriver.checkHealth();
  }

  Future<void> close() async {
    if (flutterDriver != null) {
      await flutterDriver.close();
    }
  }
}