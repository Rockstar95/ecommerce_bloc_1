abstract class ProductsEvent {

}

class GetProductsEvent extends ProductsEvent {
  bool isRefresh;

  GetProductsEvent({this.isRefresh = true});
}