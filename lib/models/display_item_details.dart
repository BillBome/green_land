import 'package:flutter/material.dart';
import 'package:green_land/firebase/item_collection.dart';
import 'package:green_land/models/update_item_details.dart';
import 'package:green_land/widgets/build-table-rows.dart';
import 'package:green_land/models/item_model.dart';

class DisplayItemDetails {
  static void show(BuildContext context, String itemId) async {
    try {
      final Item? item = await ItemFetcher().getItemById(itemId);

      if (item != null) {
        _showItemDetailsModal(context, item);
      } else {
        // Handle the case where the item is not found
        print('Item not found for ID: $itemId');
      }
    } catch (e) {
      print('Error fetching item details: $e');
    }
  }

  static void _showItemDetailsModal(BuildContext context, Item item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return _buildItemDetailsModal(context, item);
      },
    );
  }

  static Widget _buildItemDetailsModal(BuildContext context, Item item) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return FractionallySizedBox(
      heightFactor: 0.75,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Image.network(
                    item.image,
                    width: width,
                    height: height * 0.3,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(16),
                child: Table(
                  columnWidths: {
                    0: FixedColumnWidth(150),
                    1: FlexColumnWidth(2),
                  },
                  children: [
                    ItemTableRowBuilder()
                        .buildTableRow('Item ID:', '${item.id}'),
                    TableRow(
                      children: [
                        TableCell(
                          child: Container(
                            height: 10,
                          ),
                        ),
                        TableCell(
                          child: Container(),
                        ),
                      ],
                    ),
                    ItemTableRowBuilder()
                        .buildTableRow('Name:', '${item.name}'),
                    TableRow(
                      children: [
                        TableCell(
                          child: Container(
                            height: 10,
                          ),
                        ),
                        TableCell(
                          child: Container(),
                        ),
                      ],
                    ),
                    ItemTableRowBuilder().buildTableRow(
                        'Purchase Price:', '${item.purchasePrice}'),
                    TableRow(
                      children: [
                        TableCell(
                          child: Container(
                            height: 10,
                          ),
                        ),
                        TableCell(
                          child: Container(),
                        ),
                      ],
                    ),
                    ItemTableRowBuilder().buildTableRow(
                        'Selling Price:', '${item.sellingPrice}'),
                    TableRow(
                      children: [
                        TableCell(
                          child: Container(
                            height: 10,
                          ),
                        ),
                        TableCell(
                          child: Container(),
                        ),
                      ],
                    ),
                    ItemTableRowBuilder()
                        .buildTableRow('Type:', '${item.type}'),
                    TableRow(
                      children: [
                        TableCell(
                          child: Container(
                            height: 10,
                          ),
                        ),
                        TableCell(
                          child: Container(),
                        ),
                      ],
                    ),
                    ItemTableRowBuilder()
                        .buildTableRow('Description:', '${item.description}'),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        UpdateItemModal.show(context, item);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                      ),
                      child: Text(
                        'Update',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () async {
                        await ItemDeleter().deleteItem(item.id);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: Text(
                        'Delete',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
