import 'package:flutter/cupertino.dart';
import '../../model/models.dart';
import '../ApiController/apiservices.dart';


class ProductViewModel extends ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  void fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    _products = await ApiService().fetchProducts();

    _isLoading = false;
    notifyListeners();
  }
}