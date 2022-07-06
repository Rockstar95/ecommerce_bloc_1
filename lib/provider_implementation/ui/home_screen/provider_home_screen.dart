import 'package:ecommerce_bloc_1/provider_implementation/controllers/producs_controller.dart';
import 'package:ecommerce_bloc_1/provider_implementation/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../../constants/AppTheme.dart';
import '../../../models/product/product_model.dart';

class ProviderHomeScreen extends StatefulWidget {
  const ProviderHomeScreen({Key? key}) : super(key: key);

  @override
  _ProviderHomeScreenState createState() => _ProviderHomeScreenState();
}

class _ProviderHomeScreenState extends State<ProviderHomeScreen> {
  late ThemeData themeData;
  bool isFirst = true;
  ScrollController scrollController = ScrollController();
  TextEditingController productController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);

    if(isFirst) {
      isFirst = false;
      ProductsController().getProducts(context: context, isRefresh: true);
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home Screen"),
        ),
        body: Consumer<ProductsProvider>(
          builder: (BuildContext context, ProductsProvider productsProvider, Widget? child) {
            if(productsProvider.isFirstTimeLoading) {
              return Center(
                child: SpinKitCircle(color: themeData.colorScheme.primary,),
              );
            }
            else {
              List<ProductModel> productsList = List.from(productsProvider.products);
              if(productController.text.isNotEmpty) {
                productsList.removeWhere((element) => !element.product_name.toLowerCase().contains(productController.text.toLowerCase()));
              }

              return Column(
                children: [
                  getSearchProductTextField(),
                  Expanded(child: getProductsListView(productsList, productsProvider.isFirstTimeLoading, productsProvider.isLoading)),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget getSearchProductTextField() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: TextFormField(
        controller: productController,
        onChanged: (String value) {
          setState(() {});
        },
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: "Search Product",
          hintStyle: AppTheme.getTextStyle(
            themeData.textTheme.subtitle2!,
            letterSpacing: 0.1,
            color: themeData.colorScheme.onBackground,
            fontWeight: 500,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: themeData.colorScheme.primary),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: themeData.colorScheme.primary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: themeData.colorScheme.primary),
          ),
          filled: true,
          fillColor: Colors.white,
          isDense: true,
          contentPadding: const EdgeInsets.all(15),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.deny(".-"),
        ],
        validator: (val) {
          if(val?.isEmpty ?? false) {
            return "Text Cannot be empty";
          }
          else if(int.tryParse(val!) == null) {
            return "Not A Valid Number";
          }
          else{
            return null;
          }
        },
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget getProductsListView(List<ProductModel> products, bool isFirstTimeLoading, bool isLoading) {
    if(products.isEmpty) {
      return RefreshIndicator(
        onRefresh: () async {
          ProductsController().getProducts(context: context, isRefresh: true);
        },
        backgroundColor: themeData.colorScheme.onPrimary,
        child: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.4,),
            const Center(child: const Text("No Products")),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        ProductsController().getProducts(context: context, isRefresh: true);
      },
      backgroundColor: themeData.colorScheme.onPrimary,
      child: Scrollbar(
        controller: scrollController,
        child: ListView.builder(
          controller: scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: products.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if(index == products.length) {
              if(isLoading) {
                return Center(
                  child: SpinKitCircle(color: themeData.colorScheme.primary,),
                );
              }
              else {
                return const SizedBox();
              }
            }

            bool isSearchable = false;
            if(products.length >= 10) {
              if(index == products.length - 5) {
                isSearchable = true;
              }
            }
            else {
              isSearchable = true;
            }

            if(isSearchable && !isFirstTimeLoading && !isLoading) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                ProductsController().getProducts(context: context, isRefresh: false,);
              });
            }

            ProductModel productModel = products[index];

            return getProductCard(productModel);
          },
        ),
      ),
    );
  }

  Widget getProductCard(ProductModel productModel) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /*getTextWidget("Id: ${productModel.id}"),
          getTextWidget("Uid: ${productModel.uid}"),*/
          getTextWidget("Name: ${productModel.product_name}"),
          getTextWidget("Color: ${productModel.color}"),
          getTextWidget("Department: ${productModel.department}"),
          getTextWidget("Material: ${productModel.material}"),
          getTextWidget("Price: ${productModel.price_string}"),
          getTextWidget("Promo Code: ${productModel.promo_code}"),
        ],
      ),
    );
  }

  Widget getTextWidget(String text) {
    return Text(
      text,
      style: themeData.textTheme.caption?.copyWith(color: Colors.black),
    );
  }
}
