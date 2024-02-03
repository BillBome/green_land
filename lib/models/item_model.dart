class Item {
  String id;
  final String name;
  final String image;
  final double purchasePrice;
  final double sellingPrice;
  final String type;
  final String? description;

  Item({
    required this.id,
    required this.name,
    required this.image,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.type,
    this.description,
  });

  toJson() {
    return {
      "ItemId": id,
      "Name": name,
      "Image": image,
      "PurchasePrice": purchasePrice,
      "SellingPrice": sellingPrice,
      "Type": type,
      "Description": description,
    };
  }
}
