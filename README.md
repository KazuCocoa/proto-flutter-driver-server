**This project is no longer maintained.**

**Please refer to https://github.com/appium-userland/appium-flutter-driver.**


# proto_flutter_driver_server

## features
- `$ flutter driver --target=test_driver/app.dart`
- Access to:
    - `localhost:8080/hub/wd/element`: find an element by text `You have pushed the button this many times:`
    - `localhost:8080/hub/wd/element/button`: find a button named `add the number`
    - `localhost:8080/hub/wd/element/text`: Get the element text
        - After `localhost:8080/hub/wd/element`, it returns text `You have pushed the button this many times:`
    - `localhost:8080/hub/wd/element/semanticId`: Get the semantics node id for the object returned by `finder`, or the nearest ancestor with a semantics node
    - `localhost:8080/hub/wd/element/click`: find a button named `add the number`
    - `localhost:8080/hub/wd/source`: Show the result of render tree
    - `localhost:8080/hub/wd/screenshot`: Take a screenshot on the screen. It is saved on the root directory of this project. The screenshot is dart VM view.
    <img src="https://user-images.githubusercontent.com/5511591/61727173-d40bc780-adad-11e9-89f2-b09235253283.png" width=200>

This method can work for real devices, iOS and Android, if they were connected to the host machine.
e.g. [iOS case](https://github.com/KazuCocoa/proto-flutter-driver-server/issues/1)

## Why

This repository aimed to PoC for extending current Appium UIA2 driver to flutter one.
Appium can handle flutter elements via flutter_driver in addition to normal UIA2/Espresso or XCUITest driver via your favorite programming language if this works.

To make functional tests stable, using vanilla Espresso/XCUITest/flutter_driver is better handling their test target's internal state. It is kindly grey-box style, but they should specialise their platform.

We should change programming languages to implement test scenarios for them. I would like to make less change in this kind of scenario layer, ideally. So, I believe it is great if we have a layer to adapt for test scenarios and for each platform layer.

# Structure
- https://github.com/KazuCocoa/proto-flutter-driver-server/blob/master/test_driver/app.dart
    - Calls `main` in Flutter
- https://github.com/KazuCocoa/proto-flutter-driver-server/blob/master/test_driver/app_test.dart
    - Pass dart driver to Appium Driver server
- https://github.com/KazuCocoa/proto-flutter-driver-server/blob/master/test_driver/appium_driver.dart
    - HttpServer to handle http request and handle Flutter stuff via flutter_driver

# Semantics
Flutter provides [Semantics class](https://api.flutter.dev/flutter/widgets/Semantics-class.html).
We can set it like below. Then, we can find the element via `driver.bySemanticsLabel('label')`.
It is not accessibility identifier, but the feature is for accessibility tool. So, like a content-description or accessibility label.

```dart
  floatingActionButton: FloatingActionButton(
    onPressed: _incrementCounter,
    tooltip: 'Increment',
    // semanticLabel is used by accessibility model
    child: Icon(Icons.add, semanticLabel: 'add the number'),
  )
```

# Note
A prototype to write a test package which can communicate with `flutter-driver` via HTTP request

Calling `app.main();` to show Flutter UIs is necessary. We could not connect to the VM without `test_driver/app.dart`.
Maybe, we should build a library to call it in `app_test.dart` as a appium-driver server
which will be a bridge between Appium and Flutter driver.

https://kazucocoa.wordpress.com/2019/05/27/appiumfluttercalls-flutter-driver-via-httprequests/

# gif

![](https://user-images.githubusercontent.com/5511591/58382819-f54c7380-8009-11e9-8d3b-9bef3dcbfc18.gif)

# notes

- Flutter driver communicates with DartVM via VMServiceClient which is implemented by https://github.com/dart-lang/vm_service_client
    - protocol: https://github.com/dart-lang/sdk/blob/master/runtime/vm/service/service.md
- The communication protocol between Dart VM and Flutter is https://github.com/dart-lang/json_rpc_2, https://github.com/dart-lang/json_rpc_2/blob/6c1aa294ae082343a6bcdae5778ce04e1f4c1e3a/lib/src/peer.dart#L20

I wondered which was better to handle elements via flutter_driver or via direct communication with DartVM with web-socket.
`flutter_driver` has knowledge about Flutter, so we can rely on the driver about Flutter stuff while it increase communication flow though.


----

# interesting issues
Flutter team is working to make Espresso/EarlGrey accessible to Flutter semantics.
If their works well, maybe Appium also can work perfectly without Flutter Driver <=> Appium.


- Support espresso/EarlGrey integration tests on engine PRs
    - https://github.com/flutter/flutter/issues/32987
- https://github.com/google/EarlGrey/issues/778#issuecomment-447619132
- https://github.com/flutter/flutter/issues/32062
