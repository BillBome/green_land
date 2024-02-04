import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:green_land/firebase/item_collection.dart';
import 'package:green_land/models/add_new_item.dart';
import 'package:green_land/pages/landing.dart';
import 'package:green_land/pages/sign_in.dart';
import 'package:green_land/pages/sign_up.dart';

void main() {
  group("Test Integration between Landing Page, Sign In and Sign Up Page", () {
    testWidgets('Integration Test', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: LandingPage()));

      // Verify if the welcome text is displayed
      expect(find.text('Welcome to '), findsOneWidget);
      expect(find.text('GREEN LAND'), findsOneWidget);

      // Verify if the Sign In button is displayed
      expect(find.widgetWithText(ElevatedButton, 'Sign In'), findsOneWidget);

      // Tap the Sign In button and wait for the navigation to complete
      await tester.tap(find.widgetWithText(ElevatedButton, 'Sign In'));
      await tester.pumpAndSettle();

      // Verify that we are on the SignInPage
      expect(find.byType(SignInPage), findsOneWidget);

      // Verify the presence of email and password text fields.
      expect(find.byType(TextField), findsNWidgets(2));
    });
    testWidgets('Integration Test', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: LandingPage()));

      // Verify if the welcome text is displayed
      expect(find.text('Welcome to '), findsOneWidget);
      expect(find.text('GREEN LAND'), findsOneWidget);

      // Verify if the Sign In button is displayed
      expect(find.widgetWithText(ElevatedButton, 'Sign Up'), findsOneWidget);

      // Tap the Sign In button and wait for the navigation to complete
      await tester.tap(find.widgetWithText(ElevatedButton, 'Sign Up'));
      await tester.pumpAndSettle();

      // Verify that we are on the SignInPage
      expect(find.byType(SignUpPage), findsOneWidget);

      // Verify the presence of email and password text fields.
      expect(find.byType(TextField), findsNWidgets(3));
    });
  });

  testWidgets('Integration Test: Random ID and Add New Item Modal',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Builder(
        builder: (BuildContext context) {
          return ElevatedButton(
            onPressed: () {
              AddNewItemModal.show(context);
            },
            child: Text('Show AddNewItemModal'),
          );
        },
      ),
    ));

    // Tap the button to open the modal.
    await tester.tap(find.text('Show AddNewItemModal'));
    await tester.pumpAndSettle();

    // Find the TextField for 'Item ID'.
    final itemIdTextField = find
        .widgetWithText(TextField, 'Item ID')
        .evaluate()
        .first
        .widget as TextField;

    // Extract the current value from the TextEditingController.
    String generatedRandomId = itemIdTextField.controller!.text;

    // Verify that the extracted ID is not empty.
    expect(generatedRandomId, isNotEmpty);
  });

  testWidgets(
      'Integration Test: Cancel Button Clears Values of AddNewItemModal TextEditingController',
      (WidgetTester tester) async {
    // Initialize TextEditingController instances
    TextEditingController itemIdController =
        TextEditingController(text: 'TestID');
    TextEditingController nameController =
        TextEditingController(text: 'TestName');
    TextEditingController purchasePriceController =
        TextEditingController(text: '50.0');
    TextEditingController sellingPriceController =
        TextEditingController(text: '70.0');
    TextEditingController typeController =
        TextEditingController(text: 'TestType');
    TextEditingController descriptionController =
        TextEditingController(text: 'TestDescription');

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            return CancelButton.create(
              context: context,
              itemIdController: itemIdController,
              nameController: nameController,
              purchasePriceController: purchasePriceController,
              sellingPriceController: sellingPriceController,
              typeController: typeController,
              descriptionController: descriptionController,
            );
          },
        ),
      ),
    );

    // Verify the initial values in the TextEditingController instances
    expect(itemIdController.text, 'TestID');
    expect(nameController.text, 'TestName');
    expect(purchasePriceController.text, '50.0');
    expect(sellingPriceController.text, '70.0');
    expect(typeController.text, 'TestType');
    expect(descriptionController.text, 'TestDescription');

    // Trigger the CancelButton
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    // Verify that the values are cleared after pressing the CancelButton
    expect(itemIdController.text, '');
    expect(nameController.text, '');
    expect(purchasePriceController.text, '');
    expect(sellingPriceController.text, '');
    expect(typeController.text, '');
    expect(descriptionController.text, '');
  });

  testWidgets(
      'Integration Test: Cancel Button Clears Values of UpdateNewItemModal TextEditingController',
      (WidgetTester tester) async {
    // Initialize TextEditingController instances
    TextEditingController itemIdController =
        TextEditingController(text: 'TestID');
    TextEditingController nameController =
        TextEditingController(text: 'TestName');
    TextEditingController purchasePriceController =
        TextEditingController(text: '50.0');
    TextEditingController sellingPriceController =
        TextEditingController(text: '70.0');
    TextEditingController typeController =
        TextEditingController(text: 'TestType');
    TextEditingController descriptionController =
        TextEditingController(text: 'TestDescription');

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            return CancelButton.create(
              context: context,
              itemIdController: itemIdController,
              nameController: nameController,
              purchasePriceController: purchasePriceController,
              sellingPriceController: sellingPriceController,
              typeController: typeController,
              descriptionController: descriptionController,
            );
          },
        ),
      ),
    );

    // Verify the initial values in the TextEditingController instances
    expect(itemIdController.text, 'TestID');
    expect(nameController.text, 'TestName');
    expect(purchasePriceController.text, '50.0');
    expect(sellingPriceController.text, '70.0');
    expect(typeController.text, 'TestType');
    expect(descriptionController.text, 'TestDescription');

    // Trigger the CancelButton
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    // Verify that the values are cleared after pressing the CancelButton
    expect(itemIdController.text, '');
    expect(nameController.text, '');
    expect(purchasePriceController.text, '');
    expect(sellingPriceController.text, '');
    expect(typeController.text, '');
    expect(descriptionController.text, '');
  });
}
