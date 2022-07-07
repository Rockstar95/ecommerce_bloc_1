import 'package:flutter/cupertino.dart';

import '../../models/product/product_model.dart';

class ProductsProvider extends ChangeNotifier {
  List<ProductModel> products = [];
  bool isFirstTimeLoading = false, isLoading = false;
}