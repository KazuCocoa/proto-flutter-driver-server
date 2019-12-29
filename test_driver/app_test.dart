// Imports the Flutter Driver API
import 'package:test/test.dart';
import 'appium_driver.dart';

void main() {
  group('run server', () {
    Timeout defaultTimeout = Timeout.parse('5m');
    AppiumDriver driver;

    tearDown(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    test('running server', () async {
      // maybe, here is necessary part...
      AppiumDriver driver = AppiumDriver();
      await driver.start();

    }, timeout: defaultTimeout);
  });
}
