// Imports the Flutter Driver API.
import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('BFit Tracker App', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    final welcomeMessageFinder = find.byValueKey('welcomeMessage');

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      sleep(Duration(seconds: 5));
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('welcome card, welcomes the user', () async {
      SerializableFinder textWidget = find.descendant(
          of: welcomeMessageFinder,
          matching: find.byType('Text'),
          firstMatchOnly: true);

      expect(await driver.getText(textWidget), contains('Welcome back,'));
    });
  });
}
