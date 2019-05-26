# proto_flutter_driver_server

- `$ flutter driver --target=test_driver/app.dart`
- Access to:
    - `localhost:8080/hub/wd/tap`: Tap +  button
    - `localhost:8080/hub/wd/source`: Show the result of render tree

# Note
A prototype to write a test package which can communicate with `flutter-driver` via HTTP request

Calling `app.main();` to show Flutter UIs is necessary. We could not connect to the VM without `test_driver/app.dart`.
Maybe, we should build a library to call it in `app_test.dart` as a appium-driver server
which will be a bridge between Appium and Flutter driver.

# gif

![](https://user-images.githubusercontent.com/5511591/58378489-b6013100-7fcf-11e9-9799-cff2e9ec4d89.gif)

# notes

- Flutter driver try to communicate with DartVM via VMServiceClient which is implemented by https://github.com/dart-lang/vm_service_client
- The communication protocol between Dart VM and Flutter is https://github.com/dart-lang/json_rpc_2, https://github.com/dart-lang/json_rpc_2/blob/6c1aa294ae082343a6bcdae5778ce04e1f4c1e3a/lib/src/peer.dart#L20
