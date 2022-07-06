import 'package:ecommerce_bloc_1/models/product/product_model.dart';

class ProductsState {
  List<ProductModel> products = [];
  bool isFirstTimesLoading = true, isLoading = false;

  ProductsState({this.products = const [], this.isFirstTimesLoading = true, this.isLoading = false});
}

class GetProductsState extends ProductsState {
  List<ProductModel> products = [];
  bool isFirstTimesLoading = false, isLoading = false;

  GetProductsState({this.products = const [], this.isFirstTimesLoading = false, this.isLoading = false}) : super(
    isFirstTimesLoading: isFirstTimesLoading,
    isLoading: isLoading,
    products: products,
  );
}