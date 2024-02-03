import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:green_land/models/item_model.dart';
import 'package:green_land/models/update_item_details.dart';
import 'package:green_land/models/add_new_item.dart';
import 'package:green_land/pages/sign_in.dart';
import 'package:green_land/pages/sign_up.dart';

void main() {
  testWidgets('AddNewItemModal shows correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return ElevatedButton(
              onPressed: () {
                AddNewItemModal.show(context);
              },
              child: Text('Show AddNewItemModal'),
            );
          },
        ),
      ),
    ));

    // Tap the button to open the modal.
    await tester.tap(find.text('Show AddNewItemModal'));
    await tester.pumpAndSettle();

    // Verify that the modal is displayed correctly.
    expect(find.text('Item ID'), findsOneWidget);
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Purchase Price'), findsOneWidget);
    expect(find.text('Selling Price'), findsOneWidget);
    expect(find.text('Type'), findsOneWidget);
    expect(find.text('Description'), findsOneWidget);
    expect(find.text('Add'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
  });

  testWidgets('SignInPage UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: SignInPage()));

    // Verify if the email and password text fields are displayed.
    expect(find.byType(TextField), findsNWidgets(2));

    // Verify if the Sign In button is displayed.
    expect(find.widgetWithText(ElevatedButton, 'Sign In'), findsOneWidget);

    // Verify if the "Sign Up" button is displayed.
    expect(find.widgetWithText(TextButton, 'Sign Up'), findsOneWidget);

    // Tap the Sign Up button and wait for the navigation to complete.
    await tester.tap(find.widgetWithText(TextButton, 'Sign Up'));
    await tester.pumpAndSettle();

    // Verify that we are on the SignUpPage.
    expect(find.byType(SignUpPage), findsOneWidget);
  });

  testWidgets('SignUpPage UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: SignUpPage()));

    // Verify if the username, email, and password text fields are displayed.
    expect(find.byType(TextField), findsNWidgets(3));

    // Verify if the Sign Up button is displayed.
    expect(find.widgetWithText(ElevatedButton, 'Sign Up'), findsOneWidget);

    // Verify if the "Sign In" button is displayed.
    expect(find.widgetWithText(TextButton, 'Sign In'), findsOneWidget);

    // Tap the Sign In button and wait for the navigation to complete.
    await tester.tap(find.widgetWithText(TextButton, 'Sign In'));
    await tester.pumpAndSettle();

    // Verify that we are on the SignInPage.
    expect(find.byType(SignInPage), findsOneWidget);
  });

  testWidgets('UpdateItemModal UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return ElevatedButton(
              onPressed: () {
                UpdateItemModal.show(
                  context,
                  Item(
                    id: '123',
                    name: 'Test Item',
                    purchasePrice: 10.0,
                    sellingPrice: 14.0,
                    type: 'Test Type',
                    description: 'Test Description',
                    image: '',
                  ),
                );
              },
              child: Text('Show UpdateItemModal'),
            );
          },
        ),
      ),
    ));

    // Tap the button to show the modal.
    await tester.tap(find.text('Show UpdateItemModal'));
    await tester.pumpAndSettle();

    // Verify if the text fields are displayed.
    expect(find.widgetWithText(TextField, 'Item ID'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Name'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Purchase Price'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Selling Price'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Type'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Description'), findsOneWidget);

    // Verify if the "Update" and "Cancel" buttons are displayed.
    expect(find.widgetWithText(ElevatedButton, 'Update'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Cancel'), findsOneWidget);
  });
}
