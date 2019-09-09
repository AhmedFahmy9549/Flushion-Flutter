class ProductModel {
  String prodBrand;
  String prodName;
  String prodId;
  String prodCategory;
  String prodImage;
  int prodPrice;
  int prodOldPrice;
  int quantity;
  String color;
  String size;

  ProductModel(
      {this.prodName,
      this.prodId,
      this.prodCategory,
      this.prodBrand,
      this.prodImage,
      this.prodPrice,
      this.prodOldPrice,
      this.quantity,
      this.color,
      this.size});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "id": prodId,
      "name": prodName,
      "category": prodCategory,
      "image": prodImage,
      "brand": prodBrand,
      "price": prodPrice,
      "quantity": quantity,
      "quantity": quantity,
      "color": color,
      "size": size,
    };

    return map;
  }
}
