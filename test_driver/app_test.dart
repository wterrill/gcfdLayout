// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Auditor', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    final username = find.byValueKey('username');
    final password = find.byValueKey('password');
    final eyeball = find.byValueKey('eyeball');
    final login = find.byValueKey('login');
    final keepMeLoggedIn = find.byValueKey('keepMeLoggedIn');

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('username', () async {
      // Use the `driver tap, enterText and getText` method to verify the username has been entered
      await driver.tap(username);
      await driver.enterText("mxotestaud2");
      expect(await driver.getText(username), "mxotestaud2");
    });
    test('password', () async {
      // Use the `driver tap, enterText and getText` method to verify the username has been entered
      await driver.tap(password);
      await driver.enterText("Password1");
      expect(await driver.getText(password), "Password1");
    });

    test('eyeball', () async {
      // Use the `driver tap, enterText and getText` method to verify the password has been entered
      await driver.tap(eyeball);
      expect(await driver.getText(password), "mxotestaud2");
    });

    test('press keep me logged in', () async {
      //tap the button.
      await driver.tap(keepMeLoggedIn);

      // Then, verify the counter text is incremented by 1.
      expect(await driver.getText(keepMeLoggedIn), "?");
    });

    test('press log in', () async {
      //tap the button.
      await driver.tap(login);

      // Then, verify the counter text is incremented by 1.
      expect(await driver.screenshot(), "?");
    });
  });
}
