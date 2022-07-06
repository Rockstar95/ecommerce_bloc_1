import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_bloc_1/provider_implementation/providers/products_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../models/product/product_model.dart';
import '../../utils/MyPrint.dart';

class ProductsController {
  Future<List<ProductModel>> getProducts({required BuildContext context, bool isRefresh = true, bool withoutNotify = false}) async {
    MyPrint.printOnConsole("getProducts called");

    String url = "https://random-data-api.com/api/commerce/random_commerce?size=30";

    ProductsProvider productsProvider = Provider.of<ProductsProvider>(context, listen: false);

    productsProvider.isFirstTimeLoading = isRefresh;
    productsProvider.isLoading = true;
    if(productsProvider.isFirstTimeLoading) productsProvider.products.clear();
    if(!withoutNotify) productsProvider.notifyListeners();

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
              productsProvider.products.add(productModel);
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

    productsProvider.isFirstTimeLoading = false;
    productsProvider.isLoading = false;
    productsProvider.notifyListeners();

    return productsProvider.products;
  }
}