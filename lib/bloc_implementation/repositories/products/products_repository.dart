import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_bloc_1/models/product/product_model.dart';
import 'package:ecommerce_bloc_1/utils/MyPrint.dart';
import 'package:http/http.dart';

class ProductsRepository {
  Future<List<ProductModel>> getProducts() async {
    String url = "https://random-data-api.com/api/commerce/random_commerce?size=30";

    List<ProductModel> products = [];

    try {
      Response response = await get(Uri.parse(url));
      if(response.statusCode == HttpStatus.ok && response.body.isNotEmpty) {
        List list = jsonDecode(response.body);
        list.forEach((element) {
          if(element is Map) {
            Map<String, dynamic> productMap = {};
            try {
              productMap = Map.castFrom<dynamic, dynamic, String, dynamic>(element);
              ProductModel productModel = ProductModel.fromMap(productMap);
              products.add(productModel);
            }
            catch(e, s) {
              MyPrint.printOnConsole("Error in Getting Products Data to Map:${e}");
              MyPrint.printOnConsole(s);
            }
          }
        });
      }
    }
    catch(e, s) {
      MyPrint.printOnConsole("Error in Getting Products From Rest Api:${e}");
      MyPrint.printOnConsole(s);
    }

    return products;
  }
}