import 'package:flutter/foundation.dart' as foundation;
import 'product.dart';
import 'product_repository.dart';

double _salesTextRate = 0.06;
double _shippingCostPerItem = 7;

class AppStateModel extends foundation.ChangeNotifier {
  List<Product> _availableProducts;
  Category _selectedCategory = Category.all;
  final _productsInCart = <int, int>{};

  Map<int, int> get productsInCard => Map.from(_productsInCart);

  int get totalCartQuantity {
    return _productsInCart.values.fold(0, (accumulator, value) {
      return accumulator + value;
    });
  }

  Category get selectedCategory => _selectedCategory;

  Product getProductById(int id) {
    return _availableProducts.firstWhere((p) => p.id == id);
  }

  double get subtotalCost {
    return _productsInCart.keys.map((id) {
      return getProductById(id).price * _productsInCart[id];
    }).fold(0, (accumulator, value) {
      return accumulator + value;
    });
  }

  double get shippingCost {
    return _shippingCostPerItem *
        _productsInCart.values.fold(0.0, (accumulator, value) {
          return accumulator + value;
        });
  }

  double get tax {
    return subtotalCost * _salesTextRate;
  }

  double get totalCost {
    return subtotalCost + shippingCost + tax;
  }

  List<Product> getProducts() {
    if (_availableProducts == null) {
      return [];
    }

    if (_selectedCategory == Category.all) {
      return List.from(_availableProducts);
    } else {
      return _availableProducts
          .where((p) => p.category == _selectedCategory)
          .toList();
    }
  }

  List<Product> search(String searchTerms) {
    return getProducts().where((product) {
      return product.name.toLowerCase().contains(searchTerms);
    }).toList();
  }

  void addProductToCart(int productId) {
    if (!_productsInCart.containsKey(productId)) {
      _productsInCart[productId] = 1;
    } else {
      _productsInCart[productId]++;
    }

    notifyListeners();
  }

  void removeItemFormCard(int productId) {
    if (_productsInCart.containsKey(productId)) {
      if (_productsInCart[productId] == 1) {
        _productsInCart.remove(productId);
      } else {
        _productsInCart[productId]--;
      }
    }
    notifyListeners();
  }

  void clearCart() {
    _productsInCart.clear();
    notifyListeners();
  }

  void loadProducts() {
    _availableProducts = ProductRepository.loadProducts(Category.all);
    notifyListeners();
  }

  void setCategory(Category category) {
    _selectedCategory = category;
    notifyListeners();
  }
}
