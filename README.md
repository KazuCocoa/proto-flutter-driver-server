# proto_flutter_driver_server

- `$ flutter driver --target=test_driver/app.dart`
- Access to `localhost:8080/hub/wd`

# Note
A prototype to write a test package which can communicate with `flutter-driver` via HTTP request


# TODO
- check if we do not re-build the app under test

# gif

![](https://user-images.githubusercontent.com/5511591/58378489-b6013100-7fcf-11e9-9799-cff2e9ec4d89.gif)

# notes

- Flutter driver try to communicate with DartVM via VMServiceClient which is implemented by https://github.com/dart-lang/vm_service_client
- The communication protocol between Dart VM and Flutter is https://github.com/dart-lang/json_rpc_2, https://github.com/dart-lang/json_rpc_2/blob/6c1aa294ae082343a6bcdae5778ce04e1f4c1e3a/lib/src/peer.dart#L20
