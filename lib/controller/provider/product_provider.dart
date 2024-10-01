import 'package:flutter/cupertino.dart';
import '../../model/product_model.dart';
import '../services/product_api_services.dart';


class ProductProvider extends ChangeNotifier {
  var sliderImages =[
    'https://cdn.prod.website-files.com/5f6cc9cd16d59d990c8fca33/6570840942dc5c47e83df2d0_list-of-vegetables.jpg',
    'https://www.organicfacts.net/wp-content/uploads/vegetarianfood.jpg',
    "https://www.foodandwine.com/thmb/-Yxlx-cou8lNguYnp5HcNH2rX1Q=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Potatoes-May-No-Longer-Be-Considered-a-Vegetable-FT-BLOG1223-83fa6005a5bf4210aac4b1cc6fd35774.jpg",
  ];
  List<ProductModel> _products = [];
  List<ProductModel> _categoryProducts = [];
  List<ProductModel> _filteredProductsByCategory = [];
 int get cartItemsCount {
   return _products.fold(0, (previousValue, element) {
      return previousValue + element.counter;
    },);
  }

  int _count = 1;
  int get counter => _count;

  List<dynamic> _categories = [];
  bool _isLoading = false;

  List<ProductModel> get products => _products;
  List<ProductModel> get categoryProducts => _categoryProducts;
  List<ProductModel> get filteredProductsByCategory => _filteredProductsByCategory;
  List<dynamic> get categories => _categories;
  bool get isLoading => _isLoading;

  Future<void> getProducts() async {
    _isLoading = true;
    notifyListeners();

    _products = await ApiService().getProducts();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> getCategory() async {
    _isLoading = true;
    notifyListeners();
    _categories = await ApiService().getCategory();
    addCategoryProducts();
    _isLoading = false;
    notifyListeners();

  }

  addCategoryProducts(){
    for (var category in _categories) {
      for (var product in products) {
        if(product.category.toString() == category.toString()){
          _categoryProducts.add(product);
          break;
        }
      }
    }

    notifyListeners();
  }

  filterProductsCategory(String category){
    _filteredProductsByCategory.clear();
      for (var product in products) {
        if(product.category.toString() == category.toString()){
          _filteredProductsByCategory.add(product);
      }
    }
    notifyListeners();
  }

  void increment(ProductModel product) {

    product.counter++;
    product.isCounter = true;
    notifyListeners();
  }

  void decrement(ProductModel product) {
    if (product.counter > 1) {
      product.counter--;
    }else if(product.counter == 1){
      product.counter--;
      product.isCounter = false;
    }
    else {
      product.isCounter = false;

    }
    notifyListeners();
  }

}