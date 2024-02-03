import 'dart:math';
import 'package:flutter/material.dart';
import 'package:green_land/firebase/item_collection.dart';
import 'package:green_land/models/image_uploader.dart';
import 'package:green_land/models/item_model.dart';

class RandomIdGenerator {
  static String generateRandomId() {
    return "V-${Random().nextInt(9999).toString().padLeft(4, '0')}";
  }
}

class AddNewItemModal {
  static void show(BuildContext context) {
    String? imageDownloadUrl;

    TextEditingController itemIdController =
        TextEditingController(text: RandomIdGenerator.generateRandomId());
    TextEditingController nameController = TextEditingController();
    TextEditingController purchasePriceController = TextEditingController();
    TextEditingController sellingPriceController = TextEditingController();
    TextEditingController typeController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    purchasePriceController.addListener(() {
      double purchasePrice =
          double.tryParse(purchasePriceController.text) ?? 0.0;
      double sellingPrice =
          SellingPriceCalculator.calculateSellingPrice(purchasePrice);
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
                              Item newItem = Item(
                                id: itemId,
                                name: name,
                                image: imageDownloadUrl!,
                                purchasePrice: purchasePrice,
                                sellingPrice: sellingPrice,
                                type: type,
                                description: description,
                              );

                              await ItemAdder().addItem(newItem);
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
                            'Add',
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
