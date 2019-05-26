// Imports the Flutter Driver API
import 'package:test/test.dart';
import 'appium_driver.dart';

void main() {
  group('ensure text test', () {
    Timeout defaultTimeout = Timeout.parse('2m');
    AppiumDriver driver;

    tearDown(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    test('running server', () async {
      AppiumDriver driver = AppiumDriver();
      await driver.start();

    }, timeout: defaultTimeout);
  });
}
