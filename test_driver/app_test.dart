import 'dart:async';
import 'dart:io';

// Imports the Flutter Driver API
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('ensure text test', () {
    FlutterDriver driver;
    Timeout defaultTimeout = Timeout.parse('2m');

    setUp(() async {
      // Connects to the app
      // connect to dartVmServer like http://127.0.0.1:54821/7PC6jYgTdY4=/
      // Then, the driver communicate with it via the network connection
      driver = await FlutterDriver.connect();
      driver.setSemantics(true); // Need to be able to find element bySemanticsLabel
      driver.checkHealth();
    });

    tearDown(() async {
      if (driver != null) {
        // Closes the connection
        driver.close();
      }
    });

    test('running server', () async {
      var server = await HttpServer.bind('localhost', 8080);

      await for (var request in server) {
          if (request.uri.toString().startsWith('/hub/wd')) {
            SerializableFinder add = find.bySemanticsLabel('add the number');
            await driver.tap(add);
            request.response.headers.contentType
                = new ContentType('application', 'json', charset: 'utf-8');
            request.response.write('{"value": true}');
            request.response.close();
          } else {
            request.response.headers.contentType
            = new ContentType('application', 'json', charset: 'utf-8');
            request.response.write('{"value": false,'
                '"error": "No matched value",'
                '"message": "no url ${request.uri}"}');
            request.response.close();
          }
      }
    }, timeout: defaultTimeout);
  });
}
