import 'dart:async';

import 'package:ecommerce_bloc_1/models/product/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../events/products/products_event.dart';
import '../../repositories/products/products_repository.dart';
import '../../states/products/products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsRepository productsRepository = ProductsRepository();
  List<ProductModel> products = [];
  bool isFirstTimeLoading = false, isLoading = false;

  ProductsBloc() : super(ProductsState(products: [], isLoading: false, isFirstTimesLoading: false)) {
    on<GetProductsEvent>(onEventHandler);
  }

  FutureOr<void> onEventHandler(ProductsEvent event, Emitter emit) async {
    print("ProductsBloc onEventHandler called for ${event.runtimeType}");
    Stream<ProductsState> stream = mapEventToState(event);

    bool isDone = false;

    StreamSubscription streamSubscription = stream.listen(
      (ProductsState productsState) {
        emit(productsState);
      },
      cancelOnError: true,
      onDone: () {
        isDone = true;
      },
    );

    while (!isDone) {
      await Future.delayed(Duration(milliseconds: 10));
    }

    streamSubscription.cancel();
  }

  @override
  Stream<ProductsState> mapEventToState(ProductsEvent event) async* {
    if(event is GetProductsEvent) {
      isFirstTimeLoading = event.isRefresh;
      isLoading = true;
      if(isFirstTimeLoading) products.clear();

      yield GetProductsState(
        isFirstTimesLoading: isFirstTimeLoading,
        isLoading: isLoading,
        products: products,
      );

      List<ProductModel> newProducts = await productsRepository.getProducts();
      products.addAll(newProducts);
      isLoading = false;
      isFirstTimeLoading = false;

      yield GetProductsState(
        isFirstTimesLoading: isFirstTimeLoading,
        isLoading: isLoading,
        products: products,
      );
    }
  }
}