import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_land/models/item_model.dart';

abstract class DisplayItem {
  Stream<List<Item>> itemStream(String searchText);
}

class AllItemsStream implements DisplayItem {
  final CollectionReference itemsCollection =
      FirebaseFirestore.instance.collection('Items');

  @override
  Stream<List<Item>> itemStream(String searchText) {
    return itemsCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => ItemConverter.convertToItem(
              doc as DocumentSnapshot<Map<String, dynamic>>))
          .toList();
    });
  }
}

class FilteredItemStream implements DisplayItem {
  final CollectionReference itemsCollection =
      FirebaseFirestore.instance.collection('Items');

  @override
  Stream<List<Item>> itemStream(String searchText) {
    return itemsCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) {
            final Item? convertedItem = ItemConverter.convertToItem(
                doc as DocumentSnapshot<Map<String, dynamic>>);
            if (convertedItem != null &&
                (convertedItem.name
                        .toLowerCase()
                        .contains(searchText.toLowerCase()) ||
                    convertedItem.id
                        .toLowerCase()
                        .contains(searchText.toLowerCase()))) {
              return convertedItem;
            } else {
              return null; // Return null for non-matching items
            }
          })
          .whereType<Item>() // Filter out null values
          .toList();
    });
  }
}

class ItemConverter {
  static Item convertToItem(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Item(
      id: data['ItemId'],
      name: data['Name'],
      image: data['Image'],
      purchasePrice: data['PurchasePrice'].toDouble(),
      sellingPrice: data['SellingPrice'].toDouble(),
      type: data['Type'],
      description: data['Description'],
    );
  }
}
