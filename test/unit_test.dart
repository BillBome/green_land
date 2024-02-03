import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:green_land/firebase/item_collection.dart';
import 'package:green_land/widgets/build-table-rows.dart';

void main() {
  group('SellingPriceCalculator', () {
    test('calculateSellingPrice should return the correct value', () {
      // Arrange
      double purchasePrice = 100.0;

      // Act
      double sellingPrice =
          SellingPriceCalculator.calculateSellingPrice(purchasePrice);

      // Assert
      expect(sellingPrice, equals(140.0));
    });
  });

  group('TableRowBuilder Tests', () {
    test('ItemTableRowBuilder should build a valid TableRow', () {
      // Arrange
      final builder = ItemTableRowBuilder();
      final label = 'Item ID';
      final value = '123';

      // Act
      final tableRow = builder.buildTableRow(label, value);

      // Assert
      expect(tableRow, isA<TableRow>());
      expect(tableRow.children.length, equals(2));
      expect(tableRow.children[0], isA<Container>());
      expect(tableRow.children[1], isA<Text>());
      expect((tableRow.children[1] as Text).data, equals(value));
    });

    test('UserTableRowBuilder should build a valid TableRow', () {
      // Arrange
      final builder = UserTableRowBuilder();
      final label = 'User Name';
      final value = 'John Doe';

      // Act
      final tableRow = builder.buildTableRow(label, value);

      // Assert
      expect(tableRow, isA<TableRow>());
      expect(tableRow.children.length, equals(2));
      expect(tableRow.children[0], isA<Container>());
      expect(tableRow.children[1], isA<Text>());
      expect((tableRow.children[1] as Text).data, equals(value));
    });
  });
}
