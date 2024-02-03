import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:green_land/models/item_model.dart';

class ItemAdder {
  final FirebaseFirestore _itemDb = FirebaseFirestore.instance;

  Future<void> addItem(Item item) async {
    try {
      await _itemDb.collection("Items").doc(item.id).set(item.toJson());
      print("Item has been successfully added.");
    } catch (error) {
      print(error.toString());
      throw Exception('Failed to add item: $error');
    }
  }
}

class ItemFetcher {
  final FirebaseFirestore _itemDb = FirebaseFirestore.instance;

  Future<Item?> getItemById(String itemId) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _itemDb.collection("Items").doc(itemId).get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        Item item = Item(
          id: data['ItemId'],
          name: data['Name'],
          image: data['Image'],
          purchasePrice: data['PurchasePrice'].toDouble(),
          sellingPrice: data['SellingPrice'].toDouble(),
          type: data['Type'],
          description: data['Description'],
        );

        return item;
      } else {
        return null; // Item not found
      }
    } catch (error) {
      print('Error fetching item by ID: $error');
      throw Exception('Error fetching item by ID: $error');
    }
  }
}

class ItemUpdater {
  final FirebaseFirestore _itemDb = FirebaseFirestore.instance;

  Future<void> updateItem(Item updatedItem) async {
    try {
      await _itemDb
          .collection("Items")
          .doc(updatedItem.id)
          .update(updatedItem.toJson());
      print("Item has been successfully updated.");
    } catch (error) {
      print(error.toString());
      throw Exception('Failed to update item: $error');
    }
  }
}

class ItemDeleter {
  final FirebaseFirestore _itemDb = FirebaseFirestore.instance;

  Future<void> deleteItem(String itemId) async {
    try {
      await _itemDb.collection("Items").doc(itemId).delete();
      print("Item has been successfully deleted.");
    } catch (error) {
      print(error.toString());
      throw Exception('Failed to delete item: $error');
    }
  }
}

class SellingPriceCalculator {
  static double calculateSellingPrice(double purchasePrice) {
    return purchasePrice * 1.4;
  }
}

class CancelButton {
  static ElevatedButton create({
    required BuildContext context,
    required TextEditingController itemIdController,
    required TextEditingController nameController,
    required TextEditingController purchasePriceController,
    required TextEditingController sellingPriceController,
    required TextEditingController typeController,
    required TextEditingController descriptionController,
  }) {
    return ElevatedButton(
      onPressed: () {
        itemIdController.clear();
        nameController.clear();
        purchasePriceController.clear();
        sellingPriceController.clear();
        typeController.clear();
        descriptionController.clear();
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
      ),
      child: Text(
        'Cancel',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
