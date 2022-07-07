class ProductModel {
  int id = 0;
  String uid = "", color = "", department = "", material = "", product_name = "", price_string = "", promo_code = "";
  double price = 0;

  ProductModel({
    this.id = 0,
    this.uid = "",
    this.color = "",
    this.department = "",
    this.material = "",
    this.product_name = "",
    this.price_string = "",
    this.promo_code = "",
    this.price = 0,
  });

  ProductModel.fromMap(Map<String, dynamic> map) {
    id = map["id"] is int  ? map['id'] : 0;
    uid = map["uid"] is String  ? map['uid'] : "";
    color = map["color"] is String  ? map['color'] : "";
    department = map["department"] is String  ? map['department'] : "";
    material = map["material"] is String  ? map['material'] : "";
    product_name = map["product_name"] is String  ? map['product_name'] : "";
    price_string = map["price_string"] is String  ? map['price_string'] : "";
    promo_code = map["promo_code"] is String  ? map['promo_code'] : "";
    price = map["price"] is double  ? map['price'] : 0;
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "uid": uid,
      "color": color,
      "department": department,
      "material": material,
      "product_name": product_name,
      "price": price,
      "price_string": price_string,
      "promo_code": promo_code,
    };
  }
}