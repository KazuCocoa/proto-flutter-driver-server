# proto_flutter_driver_server

- `$ flutter driver --target=test_driver/app.dart`
- Access to:
    - `localhost:8080/hub/wd/element`: find an element by text `You have pushed the button this many times:`
    - `localhost:8080/hub/wd/element/button`: find a button named `add the number`
    - `localhost:8080/hub/wd/element/text`: Get the element text
        - After `localhost:8080/hub/wd/element`, it returns text `You have pushed the button this many times:`
    - `localhost:8080/hub/wd/element/semanticId`: Get the semantics node id for the object returned by `finder`, or the nearest ancestor with a semantics node
    - `localhost:8080/hub/wd/element/click`: find a button named `add the number`
    - `localhost:8080/hub/wd/source`: Show the result of render tree


# Structure
- https://github.com/KazuCocoa/proto-flutter-driver-server/blob/master/test_driver/app.dart
    - Calls `main` in Flutter
- https://github.com/KazuCocoa/proto-flutter-driver-server/blob/master/test_driver/app_test.dart
    - Pass dart driver to Appium Driver server
- https://github.com/KazuCocoa/proto-flutter-driver-server/blob/master/test_driver/appium_driver.dart
    - HttpServer to handle http request and handle Flutter stuff via flutter_driver

# Note
A prototype to write a test package which can communicate with `flutter-driver` via HTTP request

Calling `app.main();` to show Flutter UIs is necessary. We could not connect to the VM without `test_driver/app.dart`.
Maybe, we should build a library to call it in `app_test.dart` as a appium-driver server
which will be a bridge between Appium and Flutter driver.

# gif

![](https://user-images.githubusercontent.com/5511591/58382819-f54c7380-8009-11e9-8d3b-9bef3dcbfc18.gif)

# notes

- Flutter driver try to communicate with DartVM via VMServiceClient which is implemented by https://github.com/dart-lang/vm_service_client
- The communication protocol between Dart VM and Flutter is https://github.com/dart-lang/json_rpc_2, https://github.com/dart-lang/json_rpc_2/blob/6c1aa294ae082343a6bcdae5778ce04e1f4c1e3a/lib/src/peer.dart#L20
