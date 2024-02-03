import 'package:flutter/material.dart';
import 'package:green_land/firebase/item_collection.dart';
import 'package:green_land/models/image_uploader.dart';
import 'package:green_land/models/item_model.dart';

class UpdateItemModal {
  static void show(BuildContext context, Item item) {
    String? imageDownloadUrl;

    TextEditingController itemIdController =
        TextEditingController(text: item.id);
    TextEditingController nameController =
        TextEditingController(text: item.name);
    TextEditingController purchasePriceController =
        TextEditingController(text: item.purchasePrice.toString());
    TextEditingController sellingPriceController =
        TextEditingController(text: item.sellingPrice.toString());
    TextEditingController typeController =
        TextEditingController(text: item.type);
    TextEditingController descriptionController =
        TextEditingController(text: item.description ?? '');
    imageDownloadUrl = item.image;
    purchasePriceController.addListener(() {
      double purchasePrice =
          double.tryParse(purchasePriceController.text) ?? 0.0;
      double sellingPrice = purchasePrice * 1.4;
      sellingPriceController.text = sellingPrice.toStringAsFixed(2);
    });

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.85,
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
                  ImageUploader(
                    onImagePicked: (downloadUrl) {
                      imageDownloadUrl = downloadUrl;
                    },
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: itemIdController,
                          decoration: InputDecoration(labelText: 'Item ID'),
                          readOnly: true,
                        ),
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(labelText: 'Name'),
                        ),
                        TextField(
                          controller: purchasePriceController,
                          decoration:
                              InputDecoration(labelText: 'Purchase Price'),
                        ),
                        TextField(
                          controller: sellingPriceController,
                          decoration:
                              InputDecoration(labelText: 'Selling Price'),
                          readOnly: true,
                        ),
                        TextField(
                          controller: typeController,
                          decoration: InputDecoration(labelText: 'Type'),
                        ),
                        TextField(
                          controller: descriptionController,
                          decoration: InputDecoration(labelText: 'Description'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            String itemId = itemIdController.text;
                            String name = nameController.text;
                            double purchasePrice =
                                double.tryParse(purchasePriceController.text) ??
                                    0.0;
                            double sellingPrice =
                                double.tryParse(sellingPriceController.text) ??
                                    0.0;
                            String type = typeController.text;
                            String? description = descriptionController.text;

                            if (itemId.isNotEmpty &&
                                name.isNotEmpty &&
                                purchasePrice > 0 &&
                                sellingPrice > 0 &&
                                type.isNotEmpty &&
                                imageDownloadUrl != null) {
                              Item updatedItem = Item(
                                id: itemId,
                                name: name,
                                image: imageDownloadUrl!,
                                purchasePrice: purchasePrice,
                                sellingPrice: sellingPrice,
                                type: type,
                                description: description,
                              );

                              await ItemUpdater().updateItem(updatedItem);

                              itemIdController.clear();
                              nameController.clear();
                              purchasePriceController.clear();
                              sellingPriceController.clear();
                              typeController.clear();
                              descriptionController.clear();
                              Navigator.pop(context);
                            } else {
                              print('Please fill all required fields.');
                            }
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
                        CancelButton.create(
                          context: context,
                          itemIdController: itemIdController,
                          nameController: nameController,
                          purchasePriceController: purchasePriceController,
                          sellingPriceController: sellingPriceController,
                          typeController: typeController,
                          descriptionController: descriptionController,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
